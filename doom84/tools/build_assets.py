#!/usr/bin/env python3
"""Convert a user-supplied Doom shareware WAD into CE read-only AppVars.

No third-party Python packages. All coordinates, BSP nodes, segs and sectors
come from the WAD; this does not rasterize the level into a grid.
"""
import argparse
import hashlib
import json
import math
from pathlib import Path
import struct
import subprocess

ROOT = Path(__file__).resolve().parents[1]
PACK = struct.pack


class Wad:
    def __init__(self, path):
        self.data = Path(path).read_bytes()
        if self.data[:4] not in (b'IWAD', b'PWAD'):
            raise ValueError('Not a Doom WAD')
        count, directory = struct.unpack_from('<II', self.data, 4)
        if directory + count * 16 > len(self.data):
            raise ValueError('WAD directory is truncated')
        self.entries = []
        for i in range(count):
            offset, size, name = struct.unpack_from('<II8s', self.data, directory + 16*i)
            if offset + size > len(self.data):
                raise ValueError('WAD lump is truncated')
            self.entries.append((name.rstrip(b'\0').decode('ascii').upper(), self.data[offset:offset+size]))
        self.lumps = dict(self.entries)

    def records(self, data, fmt):
        return list(struct.iter_unpack('<' + fmt, data))

    def level(self, name):
        i = next(i for i, e in enumerate(self.entries) if e[0] == name)
        return dict(self.entries[i+1:i+11])

    def patch(self, name):
        data = self.lumps[name]
        w, h, left, top = struct.unpack_from('<HHhh', data)
        pixels = bytearray([255]) * (w*h)
        for x in range(w):
            pos, = struct.unpack_from('<I', data, 8+4*x)
            previous = -1
            while data[pos] != 255:
                y, length = data[pos:pos+2]
                if y <= previous:
                    y += previous
                previous = y
                for dy in range(length):
                    if y+dy < h:
                        c = data[pos+3+dy]
                        pixels[(y+dy)*w+x] = c if c != 255 else 0
                pos += length+4
        return w, h, left, top, pixels


# Thing type -> front walk frame, second frame, death frame, width, height,
# health, kind. Kind: 0 scenery, 1 monster, 2 pickup, 3 explosive barrel.
THINGS = {
    3004: ('POSSA1','POSSB1','POSSL0', 40,56,20,1),
    9: ('SPOSA1','SPOSB1','SPOSL0',40,56,30,1),
    3001: ('TROOA1','TROOB1','TROOM0',40,56,60,1),
    2035: ('BAR1A0','BAR1B0','BEXPE0',32,42,20,3),
    2028: ('COLUA0',None,None,32,48,0,0),
    24: ('POL5A0',None,None,32,48,0,0),
    10: ('PLAYW0',None,None,40,16,0,0),
    12: ('PLAYW0',None,None,40,16,0,0),
    15: ('PLAYN0',None,None,40,16,0,0),
    18: ('POSSL0',None,None,40,16,0,0),
    19: ('SPOSL0',None,None,40,16,0,0),
    35: ('CBRAA0',None,None,32,48,0,0),
    48: ('ELECA0',None,None,32,48,0,0),
    2011: ('STIMA0',None,None,24,24,0,2),
    2012: ('MEDIA0',None,None,28,24,0,2),
    2014: ('BON1A0',None,None,16,20,0,2),
    2015: ('BON2A0',None,None,16,20,0,2),
    2018: ('ARM1A0',None,None,32,24,0,2),
    2019: ('ARM2A0',None,None,32,24,0,2),
    2007: ('CLIPA0',None,None,16,16,0,2),
    2008: ('SHELA0',None,None,24,16,0,2),
    2048: ('AMMOA0',None,None,32,24,0,2),
    2049: ('SBOXA0',None,None,32,24,0,2),
    2046: ('BROKA0',None,None,32,24,0,2),
    2001: ('SHOTA0',None,None,48,20,0,2),
    2002: ('MGUNA0',None,None,48,24,0,2),
    2003: ('LAUNA0',None,None,48,24,0,2),
    5: ('BKEYA0',None,None,16,16,0,2),
    6: ('YKEYA0',None,None,16,16,0,2),
    13: ('RKEYA0',None,None,16,16,0,2),
}


def build(wad_path, out=ROOT, convbin=None):
    w = Wad(wad_path)
    level = w.level('E1M1')
    vertices = w.records(level['VERTEXES'], 'hh')
    lines = w.records(level['LINEDEFS'], '7H')
    sides = w.records(level['SIDEDEFS'], 'hh8s8s8sH')
    sectors = w.records(level['SECTORS'], 'hh8s8shHH')
    segs = w.records(level['SEGS'], '6H')
    nodes = w.records(level['NODES'], 'hhhh8hHH')
    subsectors = w.records(level['SSECTORS'], 'HH')
    things = w.records(level['THINGS'], 'hhHHH')
    pnames = w.lumps['PNAMES']
    names = [pnames[4+i*8:12+i*8].rstrip(b'\0').decode().upper() for i in range(struct.unpack_from('<I',pnames)[0])]
    texture_defs = {}
    for lump in ('TEXTURE1','TEXTURE2'):
        if lump not in w.lumps:
            continue
        data = w.lumps[lump]
        for i in range(struct.unpack_from('<I',data)[0]):
            pos, = struct.unpack_from('<I',data,4+i*4)
            name, _, tw, th, _, np = struct.unpack_from('<8sIHHIH',data,pos)
            texture_defs[name.rstrip(b'\0').decode()] = (tw, th, w.records(data[pos+22:pos+22+np*10], 'hhHHH'))
    tiles = []
    tile_names = []
    metadata = []
    cache = {}

    def tile(name, kind='wall'):
        name = (name.rstrip(b'\0').decode() if isinstance(name, bytes) else name).upper()
        if name == '-':
            return 255
        key = (kind,name)
        if key in cache:
            return cache[key]
        if kind == 'wall':
            tw, th, patches = texture_defs[name]
            if tw>256 or th>128:
                raise ValueError(f'{name}: assembly wall sampler supports at most 256x128')
            image = bytearray(tw*th)
            for ox,oy,p,_,_ in patches:
                pw,ph,_,_,pixels = w.patch(names[p])
                for y in range(ph):
                    for x in range(pw):
                        if 0 <= x+ox < tw and 0 <= y+oy < th and pixels[y*pw+x] != 255:
                            image[(y+oy)*tw+x+ox] = pixels[y*pw+x]
            size = 32
        elif kind == 'flat':
            tw = th = 64
            image = w.lumps[name]
            size = 32
        else:
            tw,th,_,_,image = w.patch(name)
            size = 64
        pixels = bytes(image[min(th-1,y*th//size)*tw+min(tw-1,x*tw//size)] for y in range(size) for x in range(size))
        index = len(tiles)
        if index >= 255:
            raise ValueError('Too many textures')
        cache[key] = index
        tiles.append(pixels)
        tile_names.append(f'{kind}:{name}')
        metadata.append((size, int(math.log2(tw)) if kind=='wall' else 6, int(math.log2(th)) if kind=='wall' else 6))
        return index

    section_data = {}
    section_data['VERTICES'] = level['VERTEXES']
    section_data['LINES'] = b''.join(PACK('<7H', *l) for l in lines)
    section_data['SIDES'] = b''.join(PACK('<hh4B', x,y,tile(up),tile(low),tile(mid),sector) for x,y,up,low,mid,sector in sides)
    section_data['SECTORS'] = b''.join(PACK('<hh6B', floor,ceil,tile(ft,'flat'),255 if ct==b'F_SKY1\0\0' else tile(ct,'flat'),max(0,min(255,light)),special,tag,0) for floor,ceil,ft,ct,light,special,tag in sectors)
    # Include an exact integer seg length for perspective-correct wall U.
    section_data['SEGS'] = b''.join(PACK('<7H',*s,round(math.hypot(vertices[s[1]][0]-vertices[s[0]][0],vertices[s[1]][1]-vertices[s[0]][1]))) for s in segs)
    section_data['SUBSECTORS'] = level['SSECTORS']
    section_data['NODES'] = level['NODES']
    start = next(t for t in things if t[3]==1)
    actors = []
    unsupported = []
    for x,y,angle,typ,flags in things:
        if not flags & 2 or flags & 16 or typ in (1,2,3,4,11):
            continue
        if typ not in THINGS:
            unsupported.append(typ)
            continue
        a,b,c,aw,ah,hp,kind = THINGS[typ]
        if a not in w.lumps:
            unsupported.append(typ)
            continue
        ta = tile(a,'sprite')
        tb = tile(b,'sprite') if b and b in w.lumps else ta
        tc = tile(c,'sprite') if c and c in w.lumps else ta
        actors.append(PACK('<hhH8B',x,y,typ,ta,tb,tc,aw,ah,hp,kind,0))
    if unsupported:
        raise ValueError(f'Unsupported E1M1 things: {unsupported}')
    section_data['ACTORS'] = b''.join(actors)
    section_data['BLOCKMAP'] = level['BLOCKMAP']
    sky = tile('SKY1')
    gun = tile('PISGA0','sprite')
    fire = tile('PISGB0','sprite')
    section_data['PALETTE'] = w.lumps['PLAYPAL'][:768]
    section_data['COLORMAP'] = w.lumps['COLORMAP'][:32*256]
    header = ['/* Generated by tools/build_assets.py. Do not edit. */', '#ifndef D84_GENERATED_H','#define D84_GENERATED_H']
    blob = bytearray(b'D84MAP01')
    # An ID couples every bank to this exact map/asset conversion.
    fingerprint = hashlib.sha256(b'd84-format-1' + b''.join(section_data.values()) + b''.join(tiles) + json.dumps(metadata).encode()).digest()[:8]
    blob += fingerprint
    for name,data in section_data.items():
        header.append(f'#define OFF_{name} {len(blob)}')
        blob += data
    if len(blob)>65000:
        raise ValueError('Map exceeds AppVar capacity')
    header += [f'#define NUM_{k} {v}' for k,v in [('VERTICES',len(vertices)),('LINES',len(lines)),('SIDES',len(sides)),('SECTORS',len(sectors)),('SEGS',len(segs)),('SUBSECTORS',len(subsectors)),('NODES',len(nodes)),('ACTORS',len(actors))]]
    header += [f'#define START_X {start[0]}',f'#define START_Y {start[1]}',f'#define START_ANGLE {round(start[2]*1024/360)%1024}',f'#define SKY_TILE {sky}',f'#define GUN_TILE {gun}',f'#define FIRE_TILE {fire}',f'#define NUM_TILES {len(tiles)}',f'#define MAP_SIZE {len(blob)}']
    triggers = [i for i,line in enumerate(lines) if line[3] in (36,88)]
    header += [f'#define NUM_WALK_TRIGGERS {len(triggers)}','static const unsigned short walk_triggers[NUM_WALK_TRIGGERS] = {'+','.join(map(str,triggers))+'};']
    out = Path(out)
    (out/'build').mkdir(parents=True,exist_ok=True)
    (out/'bin').mkdir(parents=True,exist_ok=True)
    (out/'src').mkdir(parents=True,exist_ok=True)
    files = [('D84MAP',bytes(blob))]
    banks = []
    locations = []
    bank = bytearray(b'D84TEX01'+fingerprint)
    for data in tiles:
        if len(bank)+len(data)>62000:
            banks.append(bytes(bank))
            bank = bytearray(b'D84TEX01'+fingerprint)
        locations.append((len(banks),len(bank)))
        bank += data
    banks.append(bytes(bank))
    files += [(f'D84T{i}',b) for i,b in enumerate(banks)]
    header += [f'#define NUM_BANKS {len(banks)}', 'static const unsigned char asset_id[8] = {'+','.join(str(v) for v in fingerprint)+'};', 'static const unsigned short bank_sizes[NUM_BANKS] = {'+','.join(str(len(b)) for b in banks)+'};', 'static const unsigned char tile_bank[NUM_TILES] = {'+','.join(str(b) for b,_ in locations)+'};', 'static const unsigned short tile_offset[NUM_TILES] = {'+','.join(str(o) for _,o in locations)+'};', 'static const unsigned char tile_info[NUM_TILES][3] = {'+','.join('{'+','.join(map(str,m))+'}' for m in metadata)+'};', 'static const short sine_table[1024] = {'+','.join(str(round(math.sin(i*math.tau/1024)*256)) for i in range(1024))+'};', '#endif']
    (out/'src/generated.h').write_text('\n'.join(header)+'\n')
    manifest = {'format':1,'wad_sha256':hashlib.sha256(w.data).hexdigest(),'asset_id':fingerprint.hex(),'level':'E1M1','skill':'Hurt Me Plenty','vertices':len(vertices),'lines':len(lines),'segs':len(segs),'nodes':len(nodes),'sectors':len(sectors),'actors':len(actors),'tiles':tile_names,'banks':{name:len(data) for name,data in files},'start':start[:3]}
    (out/'build/manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
    for name,data in files:
        path = out/'build'/f'{name}.bin'
        path.write_bytes(data)
        if convbin:
            subprocess.run([str(convbin),'-j','bin','-k','8xv','-r','-n',name,'-i',str(path),'-o',str(out/'bin'/f'{name}.8xv')],check=True)
    from build_geometry import build_geometry
    from build_hud import build_hud
    build_geometry(out)
    hud = build_hud(w, out)
    print(f'E1M1: {len(vertices)} vertices, {len(segs)} segs, {len(sectors)} sectors, {len(actors)} things')
    print(f'Map {len(blob):,} bytes; {len(tiles)} textures/sprites in {len(banks)} banks; total {sum(len(b) for _,b in files):,} bytes in archive')
    print(f'Pistol frames {hud["gun"][0]}x{hud["gun"][1]}; status bar ~{hud["hud_bytes"]} bytes')
    return manifest


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('wad', type=Path)
    parser.add_argument('--out',type=Path,default=ROOT)
    parser.add_argument('--convbin',type=Path,default=Path.home()/'CEdev/bin/convbin')
    args = parser.parse_args()
    build(args.wad,args.out,args.convbin)

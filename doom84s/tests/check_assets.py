#!/usr/bin/env python3
"""Check map fidelity and TI containers against the supplied source WAD."""
from pathlib import Path
import re
import struct
import sys
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tools'))
from build_assets import Wad

root=Path(__file__).resolve().parents[1]
w=Wad(sys.argv[1])
source=w.level('E1M1')
blob=(root/'build/D84MAP.bin').read_bytes()
generated=(root/'src/generated.h').read_text()
offsets={k:int(v) for k,v in re.findall(r'#define OFF_(\w+) (\d+)',generated)}
checks=0
def check(condition):
    global checks
    checks+=1
    if not condition:
        raise AssertionError(f'Asset check {checks} failed')
for section,original in [('VERTICES','VERTEXES'),('LINES','LINEDEFS'),('NODES','NODES'),('SUBSECTORS','SSECTORS'),('BLOCKMAP','BLOCKMAP')]:
    data=source[original]
    check(blob[offsets[section]:offsets[section]+len(data)]==data)
for i,seg in enumerate(w.records(source['SEGS'],'6H')):
    check(struct.unpack_from('<6H',blob,offsets['SEGS']+i*14)==seg)
for i,sector in enumerate(w.records(source['SECTORS'],'hh8s8shHH')):
    floor,ceiling,_,_,light,special,tag=sector
    record=struct.unpack_from('<hh6B',blob,offsets['SECTORS']+i*10)
    check(record[:2]==(floor,ceiling) and record[4:7]==(light,special,tag))
for p in sorted((root/'bin').glob('*.8xv')):
    data=p.read_bytes()
    check(data[:8]==b'**TI83F*')
    length,=struct.unpack_from('<H',data,53)
    check(len(data)==length+57)
    checksum,=struct.unpack_from('<H',data,len(data)-2)
    check(sum(data[55:-2])&65535==checksum)
    check(data[69]&128!=0) # archive flag in the TI variable entry
    payload=(root/'build'/f'{p.stem}.bin').read_bytes()
    check(data[74:-2]==payload)
print(f'PASS: {checks} asset fidelity/container checks')

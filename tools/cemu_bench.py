#!/usr/bin/env python3
"""Run the compiled renderer on CEmu's eZ80 core and check native parity.

Requires a separately obtained CEmu checkout; never obtains or needs a TI ROM.
The result excludes TI-OS, LCD DMA, display scaling and simulation cost.
"""
import argparse
import json
from pathlib import Path
import subprocess

root=Path(__file__).resolve().parents[1]
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--cemu',required=True,type=Path,help='CEmu checkout directory')
parser.add_argument('--cedev',type=Path,default=Path.home()/'CEdev')
args=parser.parse_args()
core=args.cemu.resolve()/'core'
def run(command,**kw):
    return subprocess.run([str(x) for x in command],cwd=root,check=True,**kw)
run(['make','-C',core,'-j4','CC=clang','CFLAGS=-O3 -std=gnu11 -fPIC'],stdout=subprocess.DEVNULL)
binutils=args.cedev/'binutils/bin'
symbols={}
for line in run([binutils/'z80-none-elf-nm','bin/E1M1.obj'],capture_output=True,text=True).stdout.splitlines():
    fields=line.split()
    if len(fields)==3:
        symbols[fields[2]]=int(fields[0],16)
required=('engine_init','engine_tick','engine_reset','engine_render','engine_view','player','render_detail','d84_set_camera','d84_rotate','d84_screen_x','camcos','camsin','d84_rotated')
(root/'build/cemu_symbols.h').write_text('\n'.join(f'#define SYM_{name} 0x{symbols["_"+name]:x}u' for name in required)+'\n')
run([binutils/'z80-none-elf-objcopy','-O','binary','bin/E1M1.obj','build/E1M1-raw.bin'])
run(['clang','-O2','-I'+str(core),'-Isrc','-Ibuild','tests/cemu_bench.c',core/'libcemucore.a','-o','build/cemu-bench'])
result=json.loads(run(['build/cemu-bench','build/E1M1-raw.bin'],capture_output=True,text=True).stdout)
run(['make','host'],stdout=subprocess.DEVNULL)
poses={'start':(1056,-3616,256),'courtyard':(1824,-3072,768),'later':(3008,-4224,768),'start-turn':(1056,-3616,341),'yard-turn':(1824,-3072,597)}
for frame in result['frames']:
    scene=frame['scene'];detail=frame['detail'];textured=frame['textured']
    reference=root/'build/reference.ppm'
    pose=list(poses[scene]);pose[2]=frame.get('angle',pose[2])
    run(['build/host','--preview',reference,*pose,textured,detail],stdout=subprocess.DEVNULL)
    suffix=f'-a{frame["angle"]}' if 'angle' in frame else ''
    emulated=root/f'build/cemu-{scene}-{detail}-{textured}{suffix}.ppm'
    if reference.read_bytes()!=emulated.read_bytes():
        raise SystemExit(f'FAIL: C/eZ80 pixel disagreement in {scene} detail={detail} textured={textured}')
    if 'angle' not in frame: print(f'{scene:10s} {128//detail:3d}x80 {"textured" if textured else "flat":8s} {frame["ms"]:8.2f} ms (renderer only)')
result['pixel_parity']=f'{len(result["frames"])}/{len(result["frames"])} frames identical to native C'
result['cemu_commit']=run(['git','-C',args.cemu,'rev-parse','HEAD'],capture_output=True,text=True).stdout.strip()
result['limitations']='Isolated renderer at 48 MHz on ASIC I; no TI-OS, LCD DMA, display scaling, input or simulation overhead. These are not whole-game FPS.'
(root/'build/cemu-benchmark.json').write_text(json.dumps(result,indent=2)+'\n')
print(result['pixel_parity'])
print(f'{result["kernel_checks"]} assembly arithmetic checks passed')
for sample in result['simulation_samples']:
    print(f'{sample["input"]}: mean tick {sample["mean_ms"]:.2f} ms, max {sample["max_ms"]:.2f} ms')

"""Build a ROM-free mixer timing module at each optimization level."""
from pathlib import Path
import subprocess,sys
root=Path(__file__).resolve().parents[1];ce=Path.home()/'CEdev';out=root/'build/usb-bench';out.mkdir(exist_ok=True)
opt=sys.argv[1] if len(sys.argv)>1 else '-Oz'
def run(args):subprocess.run(list(map(str,args)),check=True)
run([ce/'bin/ez80-clang','-S','-nostdinc','-isystem',ce/'include','-D__TICE__=1','-fno-autolink','-fno-addrsig','-mllvm','-z80-gas-style',opt,'-fno-omit-frame-pointer','-ffunction-sections','-fdata-sections',root/'tools/usb_audio_bench.c','-o',out/'bench.s'])
bin=ce/'binutils/bin'
run([bin/'z80-none-elf-as','-march=ez80+full',out/'bench.s','-o',out/'bench.o'])
run([bin/'z80-none-elf-ld','--entry=_bench_init','--gc-sections','--undefined=_bench_frame','-T',root/'tools/usb_audio_bench.ld',out/'bench.o','--start-group',ce/'lib/libc/libc.a',ce/'lib/crt/libcrt.a','--end-group','-o',out/'bench.elf'])
run([bin/'z80-none-elf-objcopy','-O','binary',out/'bench.elf',out/'bench.bin'])
symbols=subprocess.check_output([bin/'z80-none-elf-nm',out/'bench.elf'],text=True)
exports={p[2]:int(p[0],16) for line in symbols.splitlines() if len(p:=line.split())==3}
p=out/'bench.bin';p.write_bytes(p.read_bytes().ljust(exports['_module_end']-0xd1e881,b'\0'))
(out/'symbols.h').write_text('\n'.join(f'#define SYM{name} 0x{value:x}u' for name,value in exports.items() if name in ['_bench_init','_bench_frame','_bench_output','_bench_voices'])+'\n')

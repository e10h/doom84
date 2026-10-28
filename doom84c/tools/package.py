#!/usr/bin/env python3
"""Create a local TI Connect transfer ZIP without intermediate build files."""
from pathlib import Path
import argparse
import hashlib
import json
import zipfile

root = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--libraries',type=Path,help='Optional local standard CE clibs.8xg')
parser.add_argument('--output',type=Path,help='Optional output ZIP path')
args=parser.parse_args()
files = [root/'bin/E1M1.8xp', *sorted((root/'bin').glob('D84*.8xv'))]
if len(files)!=5 or not all(p.is_file() for p in files):
    raise SystemExit('Build E1M1 and all four AppVars first')
files += [root/'README.md',root/'PERFORMANCE.md',root/'LICENSE']
if args.libraries:
    files.append(args.libraries)
target=args.output or root/'bin/E1M1-transfer.zip'
with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED) as z:
    checksums={}
    for file in files:
        data=file.read_bytes()
        z.writestr(file.name,data)
        checksums[file.name]=hashlib.sha256(data).hexdigest()
    # Include the corresponding source and conversion tools in the same ZIP.
    for pattern in ('makefile','src/*.c','src/*.h','src/*.S','tools/*.py','tests/*.c','tests/*.py','build/manifest.json','build/preview.png','build/cemu-benchmark.json'):
        for file in sorted(root.glob(pattern)):
            name=str(file.relative_to(root))
            data=file.read_bytes()
            z.writestr(name,data)
            checksums[name]=hashlib.sha256(data).hexdigest()
    z.writestr('SHA256.json',json.dumps(checksums,indent=2)+'\n')
print(f'{target}: {target.stat().st_size:,} bytes')

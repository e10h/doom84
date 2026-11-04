"""Package the compact USB build and enforce a runtime image size budget."""
from pathlib import Path
import re,zipfile
root=Path(__file__).resolve().parents[1]
folder=root/'build/usb-sfx3'
text=(folder/'D84USB3.map').read_text()
end=int(re.search(r'0x([0-9a-f]+)\s+___data_high',text)[1],16)
size=end-0xd1a87f
assert size<65536, f'Expanded USB program exceeds 64 KiB: {size}'
(folder/'README.txt').write_text(f'''Doom84 USB SFX3 - compact startup test

Transfer all THREE files to Archive:
 D84USB3.8xp
 D84SFX.8xv
 D84UI.8xv
Keep your existing archived D84MAP and D84T0..3 and libraries.
Run D84USB3 (a new name), NOT DOOM84S.

Expanded executable: {size:,} bytes. Stored executable: {(folder/'D84USB3.8xp').stat().st_size:,} bytes.
HUD, gun and sound samples stay in Archive. Four-voice USB queue is
initialized program storage and does not consume the small C heap.
The executable is compiled for size; hardware startup and FPS unverified.

After the game starts, quit TI Connect CE. Connect Doom84 USB PCM
at http://127.0.0.1:3012/usb in Chrome. Fire with 2nd; CLEAR exits.
If startup still fails, report or photograph the EXACT error wording.
''')
with zipfile.ZipFile(root/'bin/doom84-usb-sfx3.zip','w',zipfile.ZIP_DEFLATED) as z:
    for path in [folder/'D84USB3.8xp',root/'bin/D84SFX.8xv',root/'bin/D84UI.8xv']:
        b=path.read_bytes()
        assert sum(b[55:-2])&65535==int.from_bytes(b[-2:],'little')
        z.write(path,path.name)
    z.write(folder/'README.txt','README.txt')
print('Verified image budget:',size,'bytes; TI checksums pass')

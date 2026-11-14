"""Package the music update; leave the working UI/SFX/map assets in place."""
from pathlib import Path
import re,zipfile
root=Path(__file__).resolve().parents[1]
folder=root/'build/usb-music5'
text=(folder/'D84USB5.map').read_text()
end=int(re.search(r'0x([0-9a-f]+)\s+___data_high',text)[1],16)
size=end-0xd1a87f
assert size<65536, f'Expanded USB program exceeds 64 KiB: {size}'
paths=[folder/'D84USB5.8xp']+[root/'bin'/f'D84M{i}.8xv' for i in range(7)]
(folder/'README.txt').write_text(f'''Doom84 USB music update

Transfer all EIGHT included files to Archive:
 D84USB5.8xp
 D84M0.8xv
 D84M1.8xv
 D84M2.8xv
 D84M3.8xv
 D84M4.8xv
 D84M5.8xv
 D84M6.8xv
Keep your existing archived D84UI, D84SFX, D84MAP, D84T0..3 and libraries.
Run D84USB5. You can delete the previous D84USB4 program after transferring.

Quit TI Connect CE. Open http://127.0.0.1:3012/usb in Chrome and connect
Doom84 USB PCM. Reconnect the USB cable if the picker is stale.
Music begins when the USB receiver drains audio. Fire with 2nd; CLEAR exits.

Full 101.19-second E1M1 render loops at 4 kHz, mixed on the calculator
with four simultaneous sampled sound effects. Music uses ready-to-play PCM reads directly from Archive.
The music banks occupy 404,831 bytes in Archive, not RAM.
Expanded program: {size:,} bytes (checked below 64 KiB).
The renderer uses speed optimizations with inlining limited to fit RAM.
ROM-free native mixer timing at 48 MHz: music alone 7.2% CPU,
four simultaneous effects plus music 33.6% CPU. These measure the mixer,
not total game/USB overhead. Previous four-voice ADPCM mixer was 96.2%.
USB events are serviced at most once per millisecond, and the transfer
slot is cached across a packet instead of searched for every sample.
Software tests cover the entire decoded track, bank transitions, looping,
mute, USB cadence/timer wrap, all sound effects and the existing engine.
Hardware music playback and game speed still need verification.
''')
with zipfile.ZipFile(root/'bin/doom84-usb-music5.zip','w',zipfile.ZIP_DEFLATED) as z:
    for p in paths:
        b=p.read_bytes();assert b[:8]==b'**TI83F*'
        assert sum(b[55:-2])&65535==int.from_bytes(b[-2:],'little')
        z.write(p,p.name)
    z.write(folder/'README.txt','README.txt')
print('Verified expanded image:',size,'bytes; all eight TI checksums pass')

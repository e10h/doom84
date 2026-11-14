#!/usr/bin/env python3
"""
Extract authentic Doom sounds and E1M1 music from WAD and generate:
1. build/sounds/*.wav (SFX)
2. build/sounds/e1m1.mid & build/sounds/e1m1_mono8.wav (E1M1 Music)
3. src/sounds_data.h (compact C sample tables for desktop play.c)
"""

import os
import sys
import struct
import wave
import subprocess

DEFAULT_WADS = [
    "/Users/ethan/Code/CoolDoom/doom1.wad",
    "/Users/ethan/Code/room/doom1.wad",
    "doom1.wad"
]

SOUND_MAP = [
    ("SFX_PISTOL", "DSPISTOL"),
    ("SFX_PLDETH", "DSPLDETH"),
    ("SFX_PLPAIN", "DSPLPAIN"),
    ("SFX_PODTH",  "DSPODTH1"),
    ("SFX_POPAIN", "DSPOPAIN"),
    ("SFX_DOROPN", "DSDOROPN"),
    ("SFX_SWTCHN", "DSSWTCHN"),
    ("SFX_ITEMUP", "DSITEMUP"),
    ("SFX_BAREXP", "DSBAREXP"),
]

def find_wad():
    if len(sys.argv) > 1 and os.path.exists(sys.argv[1]):
        return sys.argv[1]
    for w in DEFAULT_WADS:
        if os.path.exists(w):
            return w
    sys.exit("Error: Could not locate doom1.wad. Provide path as argument.")

def mus_to_midi(mus_data):
    magic, score_len, score_start, channels, sec_channels, instr_cnt = struct.unpack('<4sHHHHH', mus_data[:14])
    if magic != b'MUS\x1a':
        raise ValueError('Invalid MUS header')

    chan_map = {15: 9}
    next_chan = 0
    def get_midi_chan(mus_chan):
        nonlocal next_chan
        if mus_chan == 15: return 9
        if mus_chan not in chan_map:
            if next_chan == 9: next_chan += 1
            chan_map[mus_chan] = next_chan
            next_chan += 1
        return chan_map[mus_chan]

    pos = score_start
    midi_events = bytearray()
    queued_delta = 0

    def write_varlen(val):
        buf = bytearray()
        buf.append(val & 0x7F)
        val >>= 7
        while val > 0:
            buf.append((val & 0x7F) | 0x80)
            val >>= 7
        buf.reverse()
        return bytes(buf)

    channel_vol = {}

    while pos < len(mus_data):
        desc = mus_data[pos]; pos += 1
        mus_type = (desc >> 4) & 0x07
        mus_chan = desc & 0x0F
        last_event = desc & 0x80
        midi_chan = get_midi_chan(mus_chan)

        if mus_type == 0: # Release key
            note = mus_data[pos]; pos += 1
            midi_events += write_varlen(queued_delta)
            queued_delta = 0
            midi_events += bytes([0x80 | midi_chan, note & 0x7F, 0])
        elif mus_type == 1: # Press key
            b = mus_data[pos]; pos += 1
            note = b & 0x7F
            if b & 0x80:
                vol = mus_data[pos]; pos += 1
                channel_vol[mus_chan] = vol
            else:
                vol = channel_vol.get(mus_chan, 64)
            midi_events += write_varlen(queued_delta)
            queued_delta = 0
            midi_events += bytes([0x90 | midi_chan, note, vol & 0x7F])
        elif mus_type == 2: # Pitch wheel
            val = mus_data[pos]; pos += 1
            val14 = val << 6
            midi_events += write_varlen(queued_delta)
            queued_delta = 0
            midi_events += bytes([0xE0 | midi_chan, val14 & 0x7F, (val14 >> 7) & 0x7F])
        elif mus_type == 3: # System event
            ctrl = mus_data[pos]; pos += 1
            midi_ctrls = {10: 120, 11: 123, 12: 126, 13: 127, 14: 121}
            if ctrl in midi_ctrls:
                midi_events += write_varlen(queued_delta)
                queued_delta = 0
                midi_events += bytes([0xB0 | midi_chan, midi_ctrls[ctrl], 0])
        elif mus_type == 4: # Controller
            ctrl = mus_data[pos]; val = mus_data[pos+1]; pos += 2
            if ctrl == 0:
                midi_events += write_varlen(queued_delta)
                queued_delta = 0
                midi_events += bytes([0xC0 | midi_chan, val & 0x7F])
            else:
                ctrl_map = {1: 0, 2: 1, 3: 7, 4: 10, 5: 11, 6: 91, 7: 93, 8: 64, 9: 67}
                if ctrl in ctrl_map:
                    midi_events += write_varlen(queued_delta)
                    queued_delta = 0
                    midi_events += bytes([0xB0 | midi_chan, ctrl_map[ctrl], val & 0x7F])
        elif mus_type == 6:
            break

        if last_event:
            ticks = 0
            while True:
                b = mus_data[pos]; pos += 1
                ticks = (ticks * 128) + (b & 0x7F)
                if not (b & 0x80): break
            queued_delta += ticks

    midi_events += write_varlen(queued_delta)
    midi_events += bytes([0xFF, 0x2F, 0x00])

    header = struct.pack('>4sIHHH', b'MThd', 6, 0, 1, 70)
    track = struct.pack('>4sI', b'MTrk', len(midi_events)) + midi_events
    return header + track

def main():
    wad_path = find_wad()
    print(f"Reading sounds and music from {wad_path}...")

    script_dir = os.path.dirname(os.path.abspath(__file__))
    base_dir = os.path.dirname(script_dir)
    wav_dir = os.path.join(base_dir, "build", "sounds")
    os.makedirs(wav_dir, exist_ok=True)
    header_path = os.path.join(base_dir, "src", "sounds_data.h")

    with open(wad_path, "rb") as f:
        header = f.read(12)
        magic, numlumps, infotableofs = struct.unpack("<4sII", header)
        f.seek(infotableofs)
        lumps = {}
        for _ in range(numlumps):
            ofs, sz, name = struct.unpack("<II8s", f.read(16))
            name = name.rstrip(b"\x00").decode("ascii", errors="ignore")
            lumps[name] = (ofs, sz)

        c_arrays = []
        c_table = []

        for sfx_enum, lump_name in SOUND_MAP:
            if lump_name not in lumps:
                print(f"Warning: {lump_name} not found in WAD.")
                continue
            ofs, sz = lumps[lump_name]
            f.seek(ofs)
            data = f.read(sz)
            fmt, srate, nsamples = struct.unpack("<HHI", data[:8])
            raw_pcm = data[8:8+nsamples]

            # Write 11 kHz 8-bit WAV (for backwards compatibility / calc)
            wav_path = os.path.join(wav_dir, f"{sfx_enum.lower()}.wav")
            with wave.open(wav_path, "wb") as w:
                w.setnchannels(1)
                w.setsampwidth(1)
                w.setframerate(srate)
                w.writeframes(raw_pcm)

            # High-Fidelity: Resample to 44.1 kHz 16-bit with smooth linear interpolation
            ratio = 44100.0 / srate
            n_out = int(nsamples * ratio)
            s16_out = []
            for out_i in range(n_out):
                in_pos = out_i / ratio
                i0 = int(in_pos)
                frac = in_pos - i0
                i1 = min(i0 + 1, nsamples - 1)
                s0 = (raw_pcm[i0] - 128) * 256
                s1 = (raw_pcm[i1] - 128) * 256
                s = int(s0 + frac * (s1 - s0))
                s16_out.append(max(-32768, min(32767, s)))

            wav_44k_path = os.path.join(wav_dir, f"{sfx_enum.lower()}_44k.wav")
            with wave.open(wav_44k_path, "wb") as w:
                w.setnchannels(1)
                w.setsampwidth(2)
                w.setframerate(44100)
                w.writeframes(struct.pack(f"<{len(s16_out)}h", *s16_out))

            # Generate C array
            var_name = f"pcm_{sfx_enum.lower()}"
            bytes_str = ",".join(str(b) for b in raw_pcm)
            c_arrays.append(f"static const uint8_t {var_name}[{nsamples}] = {{{bytes_str}}};")
            c_table.append(f"    [{sfx_enum}] = {{ .data = {var_name}, .length = {nsamples}, .rate = {srate} }},")
            print(f"  {sfx_enum} ({lump_name}): {nsamples} samples @ {srate} Hz -> {wav_path} & {wav_44k_path}")

        # Extract D_E1M1 Music
        if "D_E1M1" in lumps:
            ofs, sz = lumps["D_E1M1"]
            f.seek(ofs)
            mus_data = f.read(sz)
            mid_data = mus_to_midi(mus_data)
            mid_path = os.path.join(wav_dir, "e1m1.mid")
            with open(mid_path, "wb") as m:
                m.write(mid_data)
            print(f"  D_E1M1 -> {mid_path} ({len(mid_data)} bytes)")

            # Render to WAV with fluidsynth using authentic Roland SC-55 SoundFont!
            sf2_candidates = [
                "/Users/ethan/Code/room/soundfonts/SC55Soundfont-1.2b/SC-55 SoundFont v1.2b.sf2",
                "/Users/ethan/Code/doomit/wdoom/soundfonts/SC55Soundfont-1.2b/SC-55 SoundFont v1.2b.sf2",
                "/Users/ethan/Code/gzdoom/soundfont/gzdoom.sf2",
                "/opt/homebrew/Cellar/fluid-synth/2.6.1/share/fluid-synth/sf2/VintageDreamsWaves-v2.sf2",
                "/opt/homebrew/share/soundfonts/default.sf2",
                "/usr/share/sounds/sf2/default.sf2"
            ]
            sf2 = next((s for s in sf2_candidates if os.path.exists(s)), None)
            if sf2 and subprocess.run(["which", "fluidsynth"], stdout=subprocess.DEVNULL).returncode == 0:
                stereo_44k = os.path.join(wav_dir, "e1m1_44k.wav")
                stereo_wav = os.path.join(wav_dir, "e1m1_stereo.wav")
                mono_wav = os.path.join(wav_dir, "e1m1_mono8.wav")

                # 1. Studio Quality: Render 44.1 kHz 16-bit Stereo Roland SC-55 Master
                subprocess.run(["fluidsynth", "-F", stereo_44k, "-r", "44100", "-g", "1.2", sf2, mid_path],
                               stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
                print(f"  Rendered Studio E1M1: {stereo_44k} (44100 Hz 16-bit stereo Roland SC-55)")

                # 2. Render 11 kHz mono version for legacy/calc fallback
                subprocess.run(["fluidsynth", "-F", stereo_wav, "-r", "11025", sf2, mid_path],
                               stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
                if os.path.exists(stereo_wav):
                    with wave.open(stereo_wav, "rb") as src:
                        nframes = src.getnframes()
                        raw = src.readframes(nframes)
                        mono_16 = []
                        for i in range(nframes):
                            l, r = struct.unpack_from("<hh", raw, i*4)
                            mono_16.append((l + r) // 2)
                        max_abs = max(abs(m) for m in mono_16) if mono_16 else 1
                        if max_abs == 0:
                            max_abs = 1
                        scale = 120.0 / max_abs
                        mono_u8 = bytearray(nframes)
                        for i in range(nframes):
                            v = int(mono_16[i] * scale)
                            mono_u8[i] = max(0, min(255, v + 128))
                        with wave.open(mono_wav, "wb") as dst:
                            dst.setnchannels(1)
                            dst.setsampwidth(1)
                            dst.setframerate(11025)
                            dst.writeframes(mono_u8)
                    print(f"  Rendered E1M1 music: {mono_wav} ({len(mono_u8)} bytes, 11025 Hz mono, normalized peak 120)")

    with open(header_path, "w") as f:
        f.write("/* Auto-generated by tools/build_sounds.py. Do not edit directly. */\n")
        f.write("#ifndef D84_SOUNDS_DATA_H\n#define D84_SOUNDS_DATA_H\n\n")
        f.write("#include <stdint.h>\n#include \"sound.h\"\n\n")
        f.write("typedef struct {\n    const uint8_t *data;\n    uint32_t length;\n    uint32_t rate;\n} SoundEffect;\n\n")
        f.write("\n".join(c_arrays))
        f.write("\n\nstatic const SoundEffect sound_effects[NUM_SFX] = {\n")
        f.write("\n".join(c_table))
        f.write("\n};\n\n#endif /* D84_SOUNDS_DATA_H */\n")

    print(f"Wrote C header: {header_path}")

if __name__ == "__main__":
    main()

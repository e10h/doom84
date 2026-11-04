#!/usr/bin/env python3
"""
Doom84 Optical Sound Stream Decoder (40-Cell Boolean Protocol)
Decodes real-time optical barcode audio packets from:
  1. Live camera (e.g. iPhone Continuity Camera, USB webcam)
  2. Recorded video file (e.g. iPhone video of TI-84 Plus CE screen)
Plays authentic Doom SFX in real-time as events occur.
"""

import sys
import os
import argparse
import subprocess
import threading
import numpy as np

try:
    import cv2
except ImportError:
    sys.exit("Error: opencv-python not installed. Run: pip install opencv-python")

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
BASE_DIR = os.path.dirname(SCRIPT_DIR)
SOUNDS_DIR = os.path.join(BASE_DIR, "build", "sounds")

SFX_NAMES = [
    "NONE",
    "PISTOL",
    "PLDETH",
    "PLPAIN",
    "PODTH",
    "POPAIN",
    "DOROPN",
    "SWTCHN",
    "ITEMUP",
    "BAREXP"
]

SFX_WAVS = {
    1: os.path.join(SOUNDS_DIR, "sfx_pistol_44k.wav") if os.path.exists(os.path.join(SOUNDS_DIR, "sfx_pistol_44k.wav")) else os.path.join(SOUNDS_DIR, "sfx_pistol.wav"),
    2: os.path.join(SOUNDS_DIR, "sfx_pldeth_44k.wav") if os.path.exists(os.path.join(SOUNDS_DIR, "sfx_pldeth_44k.wav")) else os.path.join(SOUNDS_DIR, "sfx_pldeth.wav"),
    3: os.path.join(SOUNDS_DIR, "sfx_plpain_44k.wav") if os.path.exists(os.path.join(SOUNDS_DIR, "sfx_plpain_44k.wav")) else os.path.join(SOUNDS_DIR, "sfx_plpain.wav"),
    4: os.path.join(SOUNDS_DIR, "sfx_podth_44k.wav") if os.path.exists(os.path.join(SOUNDS_DIR, "sfx_podth_44k.wav")) else os.path.join(SOUNDS_DIR, "sfx_podth.wav"),
    5: os.path.join(SOUNDS_DIR, "sfx_popain_44k.wav") if os.path.exists(os.path.join(SOUNDS_DIR, "sfx_popain_44k.wav")) else os.path.join(SOUNDS_DIR, "sfx_popain.wav"),
    6: os.path.join(SOUNDS_DIR, "sfx_doropn_44k.wav") if os.path.exists(os.path.join(SOUNDS_DIR, "sfx_doropn_44k.wav")) else os.path.join(SOUNDS_DIR, "sfx_doropn.wav"),
    7: os.path.join(SOUNDS_DIR, "sfx_swtchn_44k.wav") if os.path.exists(os.path.join(SOUNDS_DIR, "sfx_swtchn_44k.wav")) else os.path.join(SOUNDS_DIR, "sfx_swtchn.wav"),
    8: os.path.join(SOUNDS_DIR, "sfx_itemup_44k.wav") if os.path.exists(os.path.join(SOUNDS_DIR, "sfx_itemup_44k.wav")) else os.path.join(SOUNDS_DIR, "sfx_itemup.wav"),
    9: os.path.join(SOUNDS_DIR, "sfx_barexp_44k.wav") if os.path.exists(os.path.join(SOUNDS_DIR, "sfx_barexp_44k.wav")) else os.path.join(SOUNDS_DIR, "sfx_barexp.wav"),
}

MUSIC_WAV = os.path.join(SOUNDS_DIR, "e1m1_44k.wav") if os.path.exists(os.path.join(SOUNDS_DIR, "e1m1_44k.wav")) else os.path.join(SOUNDS_DIR, "e1m1_mono8.wav")

def start_background_music():
    """Loop E1M1 background music continuously in the background"""
    if not os.path.exists(MUSIC_WAV):
        return
    def _loop():
        while True:
            if sys.platform == "darwin":
                subprocess.run(["/usr/bin/afplay", MUSIC_WAV], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            else:
                subprocess.run(["aplay", "-q", MUSIC_WAV], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    t = threading.Thread(target=_loop, daemon=True)
    t.start()

def play_audio(wav_path):
    """Play WAV file asynchronously with native macOS afplay or system player"""
    if not os.path.exists(wav_path):
        return
    def _run():
        if sys.platform == "darwin":
            subprocess.run(["/usr/bin/afplay", wav_path], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        else:
            subprocess.run(["aplay", "-q", wav_path], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    threading.Thread(target=_run, daemon=True).start()

class OpticalAudioDecoder:
    def __init__(self, source):
        self.cap = cv2.VideoCapture(source)
        if not self.cap.isOpened():
            sys.exit(f"Failed to open video source: {source}")

        self.last_seq = None
        self.roi = None # [x1, y1, x2, y2]
        self.dragging = False
        self.drag_start = None

    def on_mouse(self, event, x, y, flags, param):
        if event == cv2.EVENT_LBUTTONDOWN:
            self.dragging = True
            self.drag_start = (x, y)
            self.roi = [x, y, x, y]
        elif event == cv2.EVENT_MOUSEMOVE and self.dragging:
            self.roi[2] = x
            self.roi[3] = y
        elif event == cv2.EVENT_LBUTTONUP:
            self.dragging = False
            x1, y1 = min(self.drag_start[0], x), min(self.drag_start[1], y)
            x2, y2 = max(self.drag_start[0], x), max(self.drag_start[1], y)
            if abs(x2 - x1) > 20 and abs(y2 - y1) > 2:
                self.roi = [x1, y1, x2, y2]
            else:
                self.roi = None

    def decode_strip(self, strip_gray):
        """Decode 40 strictly boolean cells from cropped horizontal strip"""
        h, w = strip_gray.shape
        if w < 40 or h < 2:
            return None, None, None

        # 1D horizontal intensity profile
        profile = np.mean(strip_gray, axis=0)

        # Otsu thresholding for pure boolean detection
        thresh_val, _ = cv2.threshold(strip_gray, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)

        # Sample 40 cells
        cell_w = w / 40.0
        bits = []
        for c in range(40):
            cx = int((c + 0.5) * cell_w)
            cx = min(max(cx, 0), w - 1)
            sample_val = np.mean(profile[max(0, cx-1):min(w, cx+2)])
            bits.append(1 if sample_val > thresh_val else 0)

        # 1. Verify Start Finder [1, 0, 1, 0]
        if bits[0] != 1 or bits[1] != 0 or bits[2] != 1 or bits[3] != 0:
            return None, None, None

        # 2. Verify End Finder [0, 1, 0, 1]
        if bits[36] != 0 or bits[37] != 1 or bits[38] != 0 or bits[39] != 1:
            return None, None, None

        # 3. Reconstruct Sync Byte
        sync = 0
        for i in range(8):
            if bits[4 + i]: sync |= (1 << (7 - i))
        if sync != 0xA5:
            return None, None, None

        # 4. Reconstruct Sequence Counter
        seq = 0
        for i in range(8):
            if bits[12 + i]: seq |= (1 << (7 - i))

        # 5. Reconstruct SFX Low Byte
        sfx_low = 0
        for i in range(8):
            if bits[20 + i]: sfx_low |= (1 << i)

        # 6. Reconstruct Status & Beat
        status = (1 if bits[28] else 0) | ((2 if bits[29] else 0)) | ((4 if bits[30] else 0))

        # 7. Verify Checksum
        c_byte = (sync ^ seq ^ sfx_low ^ status)
        c4 = (c_byte & 0x0F) ^ ((c_byte >> 4) & 0x0F)
        expected_c4 = 0
        for i in range(4):
            if bits[32 + i]: expected_c4 |= (1 << (3 - i))
        if c4 != expected_c4:
            return None, None, None

        sfx_mask = sfx_low | ((1 << (9 - 1)) if (status & 1) else 0)
        return seq, sfx_mask, status

    def run(self):
        cv2.namedWindow("Doom84 Boolean Optical Sound Decoder")
        cv2.setMouseCallback("Doom84 Boolean Optical Sound Decoder", self.on_mouse)

        print("\n=== Doom84 Boolean Optical Audio Decoder Running ===")
        print("40-cell strictly boolean protocol (pure black/white).")
        print("Tip: Click and drag across the top 2 rows of the calculator screen to lock onto the barcode strip.")
        print("Starting E1M1 background music...")
        start_background_music()
        print("Press 'q' or ESC to exit.\n")

        recent_events = []

        while True:
            ret, frame = self.cap.read()
            if not ret:
                self.cap.set(cv2.CAP_PROP_POS_FRAMES, 0)
                continue

            fh, fw = frame.shape[:2]
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

            # Default ROI: top 5% horizontal strip in center if user hasn't selected
            if self.roi is None:
                rx1, ry1 = int(fw * 0.1), int(fh * 0.05)
                rx2, ry2 = int(fw * 0.9), int(fh * 0.12)
            else:
                rx1, ry1, rx2, ry2 = self.roi
                rx1, rx2 = max(0, min(rx1, rx2)), min(fw, max(rx1, rx2))
                ry1, ry2 = max(0, min(ry1, ry2)), min(fh, max(ry1, ry2))

            strip = gray[ry1:ry2, rx1:rx2]
            seq, sfx_mask, status = None, None, None
            if strip.shape[0] >= 2 and strip.shape[1] >= 40:
                seq, sfx_mask, status = self.decode_strip(strip)

            is_locked = (seq is not None)
            color = (0, 255, 0) if is_locked else (0, 165, 255)
            cv2.rectangle(frame, (rx1, ry1), (rx2, ry2), color, 2)

            if is_locked and seq != self.last_seq:
                self.last_seq = seq
                active_names = []
                for sfx_id in range(1, len(SFX_NAMES)):
                    if sfx_mask & (1 << (sfx_id - 1)):
                        wav = SFX_WAVS.get(sfx_id)
                        if wav:
                            play_audio(wav)
                        name = SFX_NAMES[sfx_id]
                        active_names.append(name)
                        print(f"🎵 [OPTICAL SFX] {name} (Seq: {seq})")
                if active_names:
                    recent_events.append(", ".join(active_names))
                    if len(recent_events) > 5:
                        recent_events.pop(0)

            # Draw HUD
            status_text = f"STATUS: {'LOCKED (SYNC 0xA5 OK)' if is_locked else 'SEARCHING BOOLEAN STRIP...'}"
            cv2.putText(frame, status_text, (15, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, color, 2)
            if is_locked:
                beat = (status & 4) != 0
                info = f"Seq: {seq} | SFX: 0x{sfx_mask:02X} | Beat: {'ON' if beat else 'OFF'}"
                cv2.putText(frame, info, (15, 60), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255, 255, 255), 2)

            # Show recent triggers
            y_offset = 90
            for ev in recent_events[-3:]:
                cv2.putText(frame, f">> {ev}", (15, y_offset), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 255, 255), 2)
                y_offset += 25

            cv2.imshow("Doom84 Boolean Optical Sound Decoder", frame)
            key = cv2.waitKey(10) & 0xFF
            if key == ord('q') or key == 27:
                break

        self.cap.release()
        cv2.destroyAllWindows()

def main():
    parser = argparse.ArgumentParser(description="Doom84 Boolean Optical Sound Stream Decoder")
    parser.add_argument("--camera", type=int, default=0, help="Camera index (0 for default/Continuity Camera)")
    parser.add_argument("--video", type=str, default=None, help="Path to video file recording")
    args = parser.parse_args()

    source = args.video if args.video else args.camera
    decoder = OpticalAudioDecoder(source)
    decoder.run()

if __name__ == "__main__":
    main()

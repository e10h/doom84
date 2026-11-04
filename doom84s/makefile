NAME = DOOM84S
DESCRIPTION = "Doom84 Assembly Optimized"
COMPRESSED = YES
ARCHIVED = YES
CFLAGS = -Wall -Wextra -O3 -fno-omit-frame-pointer
CXXFLAGS = $(CFLAGS)
PREFER_OS_LIBC = NO
CEDEV ?= $(HOME)/CEdev
CEDEV_TOOLCHAIN ?= $(CEDEV)
COMMENT ?= $(shell $(CEDEV)/bin/cedev-config --comment)
export PATH := $(CEDEV)/bin:$(PATH)
include $(shell $(CEDEV)/bin/cedev-config --makefile)

.PHONY: assets host check-host preview play
assets:
	python3 tools/build_assets.py "$(WAD)" --convbin "$(CEDEV)/bin/convbin"
host: src/geometry.h src/gun.h src/hud.h
	mkdir -p build
	$(HOST_CC) -std=c11 -Wall -Wextra -Werror $(HOST_CFLAGS) -Isrc src/engine.c tests/host.c -lm -o build/host
HOST_CC ?= cc
HOST_CFLAGS ?= -O2
SDL2_CFLAGS ?= $(shell sdl2-config --cflags 2>/dev/null)
SDL2_LIBS ?= $(shell sdl2-config --libs 2>/dev/null)
check-host: host
	./build/host --test
preview: host
	./build/host --preview build/preview.ppm
# Interactive Mac/desktop window (requires SDL2: brew install sdl2).
build/play: src/geometry.h src/gun.h src/hud.h src/sound.h src/sounds_data.h tests/play.c src/engine.c
	@test -n "$(SDL2_LIBS)" || (echo 'SDL2 not found. brew install sdl2'; exit 1)
	mkdir -p build
	$(HOST_CC) -std=c11 -Wall -Wextra -Werror $(HOST_CFLAGS) -Isrc src/engine.c tests/play.c -lm $(SDL2_CFLAGS) $(SDL2_LIBS) -o build/play
play: build/play
	./build/play

src/sounds_data.h: tools/build_sounds.py
	python3 tools/build_sounds.py

src/geometry.h: src/generated.h tools/build_geometry.py
	python3 tools/build_geometry.py

.PHONY: usb-sounds check-usb-audio
usb-sounds:
	python3 tools/build_usb_sounds.py
	$(CEDEV)/bin/convbin -j bin -k 8xv -i build/usb-sfx.raw -o bin/D84SFX.8xv -n D84SFX -r
check-usb-audio:
	$(HOST_CC) -std=c11 -Wall -Wextra -Werror -fsanitize=address,undefined -Itests/support tests/usb_audio.c -o build/test-usb-audio
	./build/test-usb-audio

.PHONY: usb-build
usb-build: usb-sounds
	python3 tools/build_usb_ui.py
	python3 tools/build_usb_music.py
	$(MAKE) NAME=D84USB5 BINDIR=build/usb-music5 OBJDIR=build/usb-music5-obj CFLAGS='-Wall -Wextra -Oz -fno-omit-frame-pointer' LTOFLAGS='-O3 -fno-omit-frame-pointer' D84_ENGINE_OPT='-O3 -fno-inline-functions'
	python3 tools/package_usb_music.py

# Keep the renderer compact; optimize the audio hot loop for speed.
$(OBJDIR)/src/usb_audio.c.bc: override CFLAGS = -Wall -Wextra -O3 -fno-omit-frame-pointer

D84_ENGINE_OPT ?= -Oz
$(OBJDIR)/src/engine.c.bc: override CFLAGS = -Wall -Wextra $(D84_ENGINE_OPT) -fno-omit-frame-pointer

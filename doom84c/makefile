NAME = DOOM84C
DESCRIPTION = "Doom84 Pure C (No Assembly)"
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
build/play: src/geometry.h src/gun.h src/hud.h tests/play.c src/engine.c
	@test -n "$(SDL2_LIBS)" || (echo 'SDL2 not found. brew install sdl2'; exit 1)
	mkdir -p build
	$(HOST_CC) -std=c11 -Wall -Wextra -Werror $(HOST_CFLAGS) -Isrc src/engine.c tests/play.c -lm $(SDL2_CFLAGS) $(SDL2_LIBS) -o build/play
play: build/play
	./build/play

src/geometry.h: src/generated.h tools/build_geometry.py
	python3 tools/build_geometry.py

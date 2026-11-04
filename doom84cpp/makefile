NAME = DOOM84CP
DESCRIPTION = "Doom84 Modern C++20"
COMPRESSED = YES
ARCHIVED = YES
CXXFLAGS = -Wall -Wextra -Oz -std=c++20 -fno-omit-frame-pointer
PREFER_OS_LIBC = NO
CEDEV ?= $(HOME)/CEdev
CEDEV_TOOLCHAIN ?= $(CEDEV)
COMMENT ?= $(shell $(CEDEV)/bin/cedev-config --comment)
export PATH := $(CEDEV)/bin:$(PATH)
include $(shell $(CEDEV)/bin/cedev-config --makefile)

HOST_CXX ?= clang++
HOST_CXXFLAGS ?= -O2 -std=c++20
SDL2_CFLAGS ?= $(shell sdl2-config --cflags 2>/dev/null)
SDL2_LIBS ?= $(shell sdl2-config --libs 2>/dev/null)

DOOM_SRCS = $(wildcard src/doom/*.cpp)

.PHONY: assets host check-host preview play calc

assets:
	python3 tools/build_assets.py "$(WAD)" --convbin "$(CEDEV)/bin/convbin"

host: src/geometry.h src/gun.h src/hud.h $(DOOM_SRCS)
	mkdir -p build
	$(HOST_CXX) $(HOST_CXXFLAGS) -Wall -Wextra -Werror -Isrc $(DOOM_SRCS) tests/host.cpp -lm -o build/host

check-host: host
	./build/host --test

preview: host
	./build/host --preview build/preview.ppm

build/play: src/geometry.h src/gun.h src/hud.h $(DOOM_SRCS) tests/play.cpp
	@test -n "$(SDL2_LIBS)" || (echo 'SDL2 not found. brew install sdl2'; exit 1)
	mkdir -p build
	$(HOST_CXX) $(HOST_CXXFLAGS) -Wall -Wextra -Werror -Isrc $(DOOM_SRCS) tests/play.cpp -lm $(SDL2_CFLAGS) $(SDL2_LIBS) -o build/play

play: build/play
	./build/play

src/geometry.h: src/generated.h tools/build_geometry.py
	python3 tools/build_geometry.py

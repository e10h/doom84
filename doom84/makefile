NAME = E1M1
DESCRIPTION = "Doom E1M1 sector prototype"
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

.PHONY: assets host check-host preview
assets:
	python3 tools/build_assets.py "$(WAD)" --convbin "$(CEDEV)/bin/convbin"
host: src/geometry.h src/gun.h
	mkdir -p build
	$(HOST_CC) -std=c11 -Wall -Wextra -Werror $(HOST_CFLAGS) -Isrc src/engine.c tests/host.c -lm -o build/host
HOST_CC ?= cc
HOST_CFLAGS ?= -O2
check-host: host
	./build/host --test
preview: host
	./build/host --preview build/preview.ppm

# Generate these together from one WAD via the assets target.
src/geometry.h src/gun.h: src/generated.h tools/build_geometry.py
	python3 tools/build_geometry.py

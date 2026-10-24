# ----------------------------
# Makefile Options
# ----------------------------

NAME = CUBE
ICON = icon.png
DESCRIPTION = "Spinning 3D Colored Cube"
COMPRESSED = YES
ARCHIVED = YES

CFLAGS = -Wall -Wextra -O3
CXXFLAGS = -Wall -Wextra -O3

# ----------------------------

# Ensure CEdev toolchain path is configured
CEDEV ?= $(HOME)/CEdev
CEDEV_TOOLCHAIN ?= $(CEDEV)
COMMENT ?= $(shell $(CEDEV)/bin/cedev-config --comment)
export PATH := $(CEDEV)/bin:$(PATH)

include $(shell $(CEDEV)/bin/cedev-config --makefile)

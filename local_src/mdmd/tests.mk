#######################################################################################################################
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This file is part of project mdmd (PTXdist package mdmd).
#
# Copyright (c) 2017 WAGO Kontakttechnik GmbH & Co. KG
#
# Contributors:
#   JB: WAGO Kontakttechnik GmbH & Co. KG
#   PEn: WAGO Kontakttechnik GmbH & Co. KG
#######################################################################################################################
# Makefile for tests in PTXdist package mdmd
# This makefile uses the infrastructure provided by ct-build.


.SUFFIXES:

.PHONY: default
default: all

#######################################################################################################################
# Overridable project configuration

#ENABLE_VERBOSE = T

PROJECT_ROOT ?= .

PTXDIST_PACKAGE ?= mdmd
PTXDIST_PACKAGE_MK_FILE ?= $(PTXDIST_WORKSPACE)/rules/wago-net-001-mdmd.make

SRC_DIR = $(PROJECT_ROOT)

#######################################################################################################################
# Optional package/ platform feature configuration

-include $(SCRIPT_DIR)/platform_1.mk

#######################################################################################################################
# Custom toolchain configuration

#LINT_RULE_FILES = \
$(LINT_CONFIG_DIR)/lint-rules/pfc.lnt

#######################################################################################################################
# Build target configuration

$(DISABLE_NOT_PTXDIST)MAIN_BUILDTARGETS += 

$(DISABLE_NOT_PTXDIST)TEST_BUILDTARGETS += alltests.elf

BUILDTARGETS += $(MAIN_BUILDTARGETS) $(TEST_BUILDTARGETS)

$(DISABLE_NOT_PTXDIST)INSTALL_TARGETS += 

#######################################################################################################################
# Settings for build target alltests.elf

alltests.elf_STATICALLYLINKED += gmock_main gmock
alltests.elf_LIBS += gmock gmock_main
alltests.elf_PKG_CONFIGS += oslinux glib-2.0 gio-2.0 dbus-1 fuse3 typelabel
alltests.elf_DISABLEDWARNINGS += 
alltests.elf_PREREQUISITES += $(call lib_buildtarget,$(alltests.elf_LIBS),alltests.elf)
alltests.elf_CPPFLAGS += -I$(PROJECT_ROOT)/test-inc
alltests.elf_CPPFLAGS += -D_FILE_OFFSET_BITS=64
alltests.elf_CPPFLAGS += -include $(PROJECT_ROOT)/test-src/preinclude.h
alltests.elf_CPPFLAGS += $(call pkg_config_cppflags,$(alltests.elf_PKG_CONFIGS))
alltests.elf_CFLAGS += $(call option_std,gnu99)
alltests.elf_CXXFLAGS += $(call option_disable_warning,$(alltests.elf_DISABLEDWARNINGS))
alltests.elf_CXXFLAGS += $(call option_disable_warning,abi-tag useless-cast)
alltests.elf_CXXFLAGS += $(call pkg_config_cxxflags,$(alltests.elf_PKG_CONFIGS))
alltests.elf_CXXFLAGS += $(call option_std,gnu++11)
alltests.elf_LDFLAGS += $(call option_lib,$(alltests.elf_LIBS),alltests.elf)
alltests.elf_LDFLAGS += $(call pkg_config_ldflags,$(alltests.elf_PKG_CONFIGS))
alltests.elf_SOURCES += $(call fglob_r,$(PROJECT_ROOT)/test-src,$(SOURCE_FILE_EXTENSIONS))
alltests.elf_SOURCES += $(PROJECT_ROOT)/persistent_storage.cc
alltests.elf_SOURCES += $(PROJECT_ROOT)/mdm_cuse_text_data.cc
alltests.elf_SOURCES += $(PROJECT_ROOT)/mdmd_log.cc

#######################################################################################################################
# Build infrastructure

-include $(SCRIPT_DIR)/buildclang_1.mk

#######################################################################################################################
# Custom rules

#######################################################################################################################
# Bootstrapping

$(SCRIPT_DIR)/%.mk:
	$(error build scripts unavailable - set script dir (SCRIPT_DIR=$(SCRIPT_DIR)), checkout or import projects)

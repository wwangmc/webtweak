THEOS_DEVICE_IP=localhost
THEOS_DEVICE_PORT=2222
ROOTLESS = 1
ifeq ($(ROOTLESS),1)
 THEOS_PACKAGE_SCHEME=rootless
endif
ifeq ($(THEOS_PACKAGE_SCHEME), rootless)
 TARGET = iphone:clang:latest:15.0
else
 TARGET = iphone:clang:latest:12.0
endif
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = webtweak
# 寻找当前目录下所有.x或.xm的文件以及 GCDWebServer下所有的.m文件
webtweak_FILES = $(wildcard *.x*) $(wildcard GCDWebServer/**/*.m)


webtweak_CFLAGS = -fobjc-arc
# 添加头文件搜索
INCLUDE_PATHS := $(shell find GCDWebServer -type d)
webtweak_CFLAGS += $(INCLUDE_PATHS:%=-I%)
webtweak_PRIVATE_FRAMEWORKS = CFNetwork
include $(THEOS_MAKE_PATH)/tweak.mk

THEOS_DEVICE_IP=localhost
THEOS_DEVICE_PORT=2222
DEBUG = 0
FINALPACKAGE = 1
# 定义打包模式常量
ROOTFULL = 0
ROOTLESS = 1
ROOTHIDE = 2

# 默认使用 rootfull (0)，可通过命令行覆盖，如 `make TYPE=1` 选择 rootless
TYPE ?= $(ROOTLESS)

TARGET = iphone:clang:16.5:15.0
ifeq ($(TYPE), $(ROOTLESS))
    THEOS_PACKAGE_SCHEME = rootless
else ifeq ($(TYPE), $(ROOTHIDE))
    THEOS_PACKAGE_SCHEME = roothide
else 
	TARGET = iphone:clang:16.5:12.0
endif
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = webtweak
# 寻找当前目录下所有.x或.xm的文件以及 GCDWebServer下所有的.m文件
webtweak_FILES = $(wildcard *.x*)


webtweak_CFLAGS = -Wno-error -Wno-module-import-in-extern-c -fobjc-arc

webtweak_PRIVATE_FRAMEWORKS = CFNetwork
webtweak_EXTRA_FRAMEWORKS = GCDWebServers
include $(THEOS_MAKE_PATH)/tweak.mk

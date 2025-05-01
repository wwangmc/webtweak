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

webtweak_FILES = Tweak.x \
					  $(wildcard GCDWebServer/Core/*.m) \
                      $(wildcard GCDWebServer/Requests/*.m) \
                      $(wildcard GCDWebServer/Responses/*.m)


webtweak_CFLAGS = -fobjc-arc
# 添加头文件搜索
webtweak_CFLAGS += -I./GCDWebServer/Core -I./GCDWebServer/Requests -I./GCDWebServer/Responses
webtweak_PRIVATE_FRAMEWORKS = CFNetwork
include $(THEOS_MAKE_PATH)/tweak.mk

include $(MAKE_ROOT)/settings.mk

ifeq ($(RADIANT_BUILD_PLATFORM), x86)
MSBUILD_PLATFORM=Win32
else
MSBUILD_PLATFORM=x64
endif

.PHONY: default
default:
	$(MSBUILD_SERIAL) solutions/luabind.sln -p:configuration=debug,platform=$(MSBUILD_PLATFORM)
	$(MSBUILD_SERIAL) solutions/luabind.sln -p:configuration=release,platform=$(MSBUILD_PLATFORM)

.PHONY: clean
clean:
	-rm -rf solutions/debug
	-rm -rf solutions/release

include $(MAKE_ROOT)/settings.mk

# macOS
ifeq ($(RADIANT_OS_PLATFORM), macos)
.PHONY: default
default:
	mkdir -p build
	$(CMAKE) -H. -Bbuild -DCMAKE_BUILD_TYPE=RelWithDebInfo -G $(RADIANT_CMAKE_GENERATOR) -DBOOST_ROOT=$(RADIANT_BOOST_ROOT) -DLUA_INCLUDE_DIR=../lua/package/lua-5.1.5-coco/src/ -DLUA_LIBRARIES=lua -DLUA_LIBRARY_DIR=../lua/package/lua-5.1.5-coco/src/ -DBUILD_TESTING=false
	cmake --build build

.PHONY: clean
clean:
	-rm -rf build

# Windows
else

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
	-rm -rf build
endif

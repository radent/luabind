include $(MAKE_ROOT)/settings.mk

ifeq ($(RADIANT_BUILD_PLATFORM), x86)
MSBUILD_PLATFORM=Win32
else
MSBUILD_PLATFORM=x64
endif

.PHONY: default
default:
	mkdir -p build
	cd build && cmake -G $(RADIANT_CMAKE_GENERATOR) -DBOOST_ROOT=$(RADIANT_BOOST_ROOT) -DLUA_INCLUDE_DIR=../../lua/package/lua-5.1.5-coco/src/ -DLUA_LIBRARIES=lua -DLUA_LIBRARY_DIR=../../lua/package/lua-5.1.5-coco/src/ -DBUILD_TESTING=false ..
	#cd build && cmake -G $(RADIANT_CMAKE_GENERATOR) -DBOOST_ROOT=$(RADIANT_BOOST_ROOT) -DLUA_DIR=../../lua/package/lua-5.1.5-coco/ ..
	cd build && cmake --build .
	#$(MSBUILD_SERIAL) solutions/luabind.sln -p:configuration=debug,platform=$(MSBUILD_PLATFORM)
	#$(MSBUILD_SERIAL) solutions/luabind.sln -p:configuration=release,platform=$(MSBUILD_PLATFORM)

.PHONY: clean
clean:
	-rm -rf solutions/debug
	-rm -rf solutions/release
	-rm -rf build

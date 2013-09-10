include $(MAKE_ROOT)/settings.mk

.PHONY: default
default:
	$(MSBUILD) solutions/luabind.sln -p:configuration=debug
	$(MSBUILD) solutions/luabind.sln -p:configuration=release

.PHONY: clean
clean:
	-rm -rf solutions/debug
	-rm -rf solutions/release

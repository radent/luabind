SET(Luabind_ROOT "${RADIANT_MODULE_ROOT}/luabind")
set(Luabind_INCLUDE_DIRS "${Luabind_ROOT}")
set(Luabind_LIBRARIES
   optimized ${Luabind_ROOT}/solutions/Release/luabind.lib
   debug     ${Luabind_ROOT}/solutions/Debug/luabind.lib)

set(Luabind_FOUND TRUE)

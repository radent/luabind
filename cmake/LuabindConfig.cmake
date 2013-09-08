SET(Luabind_ROOT "${RADIANT_DEPENDENCY_ROOT}/Luabind-0.9.1/package")
set(Luabind_INCLUDE_DIRS "${Luabind_ROOT}")
set(Luabind_LIBRARIES
   optimized ${Luabind_ROOT}/msvc/Release/luabind.lib
   debug     ${Luabind_ROOT}/msvc/Debug/luabind.lib)

set(Luabind_FOUND TRUE)

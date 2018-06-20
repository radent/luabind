SET(Luabind_ROOT "${RADIANT_MODULE_ROOT}/luabind")
SET(Luabind_INCLUDE_DIRS "${Luabind_ROOT}")

IF(WIN32)
    IF("${RADIANT_BUILD_PLATFORM}" STREQUAL "x86")
        SET(Luabind_LIBRARIES
            optimized ${Luabind_ROOT}/solutions/Release/luabind.lib
            debug     ${Luabind_ROOT}/solutions/Debug/luabind.lib)
    ELSE()
        SET(Luabind_LIBRARIES
            optimized ${Luabind_ROOT}/solutions/${RADIANT_BUILD_PLATFORM}/Release/luabind.lib
            debug     ${Luabind_ROOT}/solutions/${RADIANT_BUILD_PLATFORM}/Debug/luabind.lib)
    ENDIF()
ELSEIF(APPLE)
    SET(Luabind_LIBRARIES
        optimized ${Luabind_ROOT}/build/src/RelWithDebInfo/libluabind.a
        debug     ${Luabind_ROOT}/build/src/RelWithDebInfo/libluabind.a)
ENDIF()

set(Luabind_FOUND TRUE)

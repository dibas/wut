cmake_minimum_required(VERSION 3.2)

set(CMAKE_SYSTEM_PROCESSOR "ppc")
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)

set(DEVKITPPC $ENV{DEVKITPPC} CACHE STRING "Path to devkitPPC install")
set(WUT_ROOT $ENV{WUT_ROOT}   CACHE STRING "Path to wut install")

if(NOT DEVKITPPC)
   message(FATAL_ERROR "You must have defined DEVKITPPC before calling cmake.")
endif()

if(NOT WUT_ROOT)
   get_filename_component(WUT_ROOT ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
endif()

set(CMAKE_ASM_COMPILER     "${DEVKITPPC}/bin/powerpc-eabi-gcc" CACHE PATH "")
set(CMAKE_C_COMPILER       "${DEVKITPPC}/bin/powerpc-eabi-gcc" CACHE PATH "")
set(CMAKE_CXX_COMPILER     "${DEVKITPPC}/bin/powerpc-eabi-g++" CACHE PATH "")
set(CMAKE_LINKER           "${DEVKITPPC}/bin/powerpc-eabi-ld"  CACHE PATH "")
set(CMAKE_AR               "${DEVKITPPC}/bin/powerpc-eabi-ar"  CACHE PATH "")

set(WUT_C_FLAGS            "-mcpu=750 -meabi -mhard-float -Wl,-q \"-I${WUT_ROOT}/include\"")
set(CMAKE_C_FLAGS          "${WUT_C_FLAGS}" CACHE STRING "")
set(CMAKE_CXX_FLAGS        "${WUT_C_FLAGS}" CACHE STRING "")
set(CMAKE_ASM_FLAGS        "${WUT_C_FLAGS}" CACHE STRING "")
set(CMAKE_EXE_LINKER_FLAGS "-Wl,-z,nocopyreloc -T \"${WUT_ROOT}/share/wut.ld\" \"-L${WUT_ROOT}/lib\"" CACHE STRING "")

# Setup root to exclude host system headers + libraries
set(CMAKE_FIND_ROOT_PATH "${DEVKITPPC}" "${WUT_ROOT}/bin" "${CMAKE_INSTALL_PREFIX}" "${CMAKE_INSTALL_PREFIX}/share")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Tools
set(WUT_ELF2RPL "${WUT_ROOT}/bin/elf2rpl${CMAKE_EXECUTABLE_SUFFIX}" CACHE PATH "")

# Flags
set(WUT TRUE)
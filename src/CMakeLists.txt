cmake_minimum_required(VERSION 3.6)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

project(hello_world)

find_package(IncludeOS REQUIRED)
include(os)

os_add_executable(hello "Hello world - OS included" main.cpp)
os_add_stdout(hello default_stdout)

set(ELF_SYMBOLS true)
set(BINARY_NAME hello)
set(ELF_TARGET ${BINARY_NAME}${ELF_POSTFIX})

install(TARGETS ${ELF_TARGET} DESTINATION bin)

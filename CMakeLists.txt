cmake_minimum_required(VERSION 3.20.0)

project(mlir-tutorial LANGUAGES CXX C)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(BUILD_DEPS ON)

find_package(MLIR REQUIRED CONFIG)

message(STATUS "Using MLIRConfig.cmake in ${MLIR_DIR}")
message(STATUS "Using LLVMConfig.cmake in ${LLVM_DIR}")

set(MLIR_BINARY_DIR ${CMAKE_BINARY_DIR})

include(AddLLVM)
include(TableGen)

list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
include(AddMLIR)
include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})
include_directories(${PROJECT_SOURCE_DIR})
include_directories(${PROJECT_SOURCE_DIR}/externals/llvm-project)
include_directories(${PROJECT_BINARY_DIR})

#message(STATUS "Fetching or-tools...")
#include(FetchContent)
#FetchContent_Declare(
#    or-tools
#    GIT_REPOSITORY https://github.com/google/or-tools.git
#    GIT_TAG        v9.0
#)
#FetchContent_MakeAvailable(or-tools)
#message(STATUS "Done fetching or-tools")

add_subdirectory(lib)
add_subdirectory(tools)
add_subdirectory(tests)

add_custom_target(
    CreateCompileCommands ALL
    COMMAND echo > compile_commands.json && test -f ${PROJECT_BINARY_DIR}/compile_commands.json && cat ${PROJECT_BINARY_DIR}/compile_commands.json | head -n -1 >> compile_commands.json && echo "," >> compile_commands.json && cat ${PROJECT_SOURCE_DIR}/externals/llvm-project/build/compile_commands.json | tail -n +2 >> compile_commands.json || cp ${PROJECT_SOURCE_DIR}/externals/llvm-project/build/compile_commands.json .
    DEPENDS tutorial-opt tutorial-lsp-server
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    COMMENT "Creating compile_commands.json"
)

add_custom_target(build-full
    DEPENDS tutorial-opt tutorial-lsp-server check-mlir-tutorial CreateCompileCommands
)

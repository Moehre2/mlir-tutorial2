#!/bin/bash

BUILD_DIR=externals/llvm-project/build

git submodule update --init --recursive --remote

mkdir -p $BUILD_DIR
cd $BUILD_DIR

BUILD_SYSTEM="Unix Makefiles"
if [ $(which ninja) ]; then
    BUILD_SYSTEM="Ninja"
fi
if [ $(which ccache) ]; then
    USE_CCACHE=ON
else
    USE_CCACHE=OFF
fi
if [ $(which lld) ]; then
    USE_LLD=ON
else
    USE_LLD=OFF
fi

cmake -G "$BUILD_SYSTEM" ../llvm \
	-DLLVM_ENABLE_PROJECTS=mlir \
	-DLLVM_BUILD_EXAMPLES=ON \
	-DLLVM_TARGETS_TO_BUILD="Native;NVPTX;AMDGPU" \
	-DCMAKE_BUILD_TYPE=Release \
	-DLLVM_ENABLE_ASSERTIONS=ON \
	-DCMAKE_C_COMPILER=clang \
	-DCMAKE_CXX_COMPILER=clang++ \
	-DLLVM_ENABLE_LLD=$USE_LLD \
	-DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
	-DLLVM_CCACHE_BUILD=$USE_CCACHE \
	-DCMAKE_C_COMPILER_LAUNCHER=ccache \
	-DCMAKE_CXX_COMPILER_LAUNCHER=ccache
cmake --build . --target check-mlir

#!/bin/bash

BUILD_DIR=build
LLVM_BUILD_DIR=externals/llvm-project/build

BUILD_SYSTEM="Unix Makefiles"
if [ $(which ninja) ]; then
    BUILD_SYSTEM="Ninja"
fi

mkdir -p $BUILD_DIR
pushd $BUILD_DIR

cmake -G $BUILD_SYSTEM .. \
    -DLLVM_DIR="$LLVM_BUILD_DIR/lib/cmake/llvm" \
    -DMLIR_DIR="$LLVM_BUILD_DIR/lib/cmake/mlir" \
    -DBUILD_DEPS="ON" \
    -DBUILD_SHARED_LIBS="OFF" \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1

popd

cmake --build $BUILD_DIR --target build-full

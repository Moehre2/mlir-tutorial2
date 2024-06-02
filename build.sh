#!/bin/bash

BUILD_SYSTEM="Ninja"
BUILD_DIR=./build

mkdir -p $BUILD_DIR
pushd $BUILD_DIR

LLVM_BUILD_DIR=../llvm-project/build-mlir
cmake -G $BUILD_SYSTEM .. \
    -DLLVM_DIR="$LLVM_BUILD_DIR/lib/cmake/llvm" \
    -DMLIR_DIR="$LLVM_BUILD_DIR/lib/cmake/mlir" \
    -DBUILD_DEPS="ON" \
    -DBUILD_SHARED_LIBS="OFF" \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1

popd

cmake --build $BUILD_DIR --target mlir-headers
cmake --build $BUILD_DIR --target mlir-doc
cmake --build $BUILD_DIR --target tutorial-opt

echo > compile_commands.json
if [ -f $BUILD_DIR/compile_commands.json ]; then
    cat $BUILD_DIR/compile_commands.json | head -n -1 >> compile_commands.json
    echo "," >> compile_commands.json
    cat $LLVM_BUILD_DIR/compile_commands.json | tail -n +2 >> compile_commands.json
else
    cp $LLVM_BUILD_DIR/compile_commands.json .
fi

#!/bin/bash

BUILD_DIR=build

./setup.sh

rm -rf $BUILD_DIR
./build.sh

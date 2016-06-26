#!/bin/bash
# based on newlib-1.10.0.sh by by Naomi Peori (naomi@peori.ca)
# modified by Rafał Kołucki <BluRaf@gmx.com>

NEWLIB_VERSION=2.4.0.20160527

## Download the source code.
SOURCE=ftp://sourceware.org/pub/newlib/newlib-$NEWLIB_VERSION.tar.gz
wget --continue $SOURCE || { exit 1; }

## Unpack the source code.
echo Decompressing newlib $NEWLIB_VERSION. Please wait.
rm -Rf newlib-$NEWLIB_VERSION && tar xfz newlib-$NEWLIB_VERSION.tar.gz || { exit 1; }

## Enter the source directory.
cd newlib-$NEWLIB_VERSION || { exit 1; }

## Determine the maximum number of processes that Make can work with.
## MinGW's Make doesn't work properly with multi-core processors.
OSVER=$(uname)
if [ ${OSVER:0:10} == MINGW32_NT ]; then
	PROC_NR=2
else
	PROC_NR=$(nproc)
fi

TARGET="score-elf"

## Create and enter the build directory.
mkdir build-$TARGET && cd build-$TARGET || { exit 1; }

## Configure the build.
../configure --prefix="$HSDEV/$TARGET" --target="$TARGET" || { exit 1; }

## Compile and install.
make clean && make -j $PROC_NR && make install && make clean || { exit 1; }

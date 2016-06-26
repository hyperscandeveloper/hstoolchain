#!/bin/bash
# based on binutils-2.14.sh by Naomi Peori (naomi@peori.ca)
# modified by Rafał Kołucki <BluRaf@gmx.com>

BINUTILS_VERSION=2.36

## Download the source code.
SOURCE=http://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.bz2
wget --continue $SOURCE || { exit 1; }

## Unpack the source code.
echo Decompressing Binutils $BINUTILS_VERSION. Please wait.
rm -Rf binutils-$BINUTILS_VERSION && tar xfj binutils-$BINUTILS_VERSION.tar.bz2 || { exit 1; }

## Enter the source directory.
cd binutils-$BINUTILS_VERSION || { exit 1; }

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

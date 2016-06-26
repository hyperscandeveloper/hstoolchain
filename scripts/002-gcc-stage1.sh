#!/bin/bash
# based on gcc-3.2.2-stage1.sh by Naomi Peori (naomi@peori.ca)
# modified by Rafał Kołucki <BluRaf@gmx.com>

GCC_VERSION=4.9.4

## Download the source code.
SOURCE=http://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.bz2
wget --continue $SOURCE || { exit 1; }

## Unpack the source code.
echo Decompressing GCC $GCC_VERSION. Please wait.
rm -Rf gcc-$GCC_VERSION && tar xfj gcc-$GCC_VERSION.tar.bz2 || { exit 1; }

## Enter the source directory and patch the source code.
cd gcc-$GCC_VERSION || { exit 1; }
if [ -e ../../patches/gcc-gnu_inline.patch ]; then
	cat ../../patches/gcc-gnu_inline.patch | patch -p1 || { exit 1; }
fi

OSVER=$(uname)

## Apple needs to pretend to be linux
if [ ${OSVER:0:6} == Darwin ]; then
	TARG_XTRA_OPTS="--build=i386-linux-gnu --host=i386-linux-gnu"
else
	TARG_XTRA_OPTS=""
fi

## Determine the maximum number of processes that Make can work with.
## MinGW's Make doesn't work properly with multi-core processors.
if [ ${OSVER:0:10} == MINGW32_NT ]; then
	PROC_NR=2
else
	PROC_NR=$(nproc)
fi

TARGET="score-elf"

./contrib/download_prerequisites

## Create and enter the build directory.
mkdir build-$TARGET-stage1 && cd build-$TARGET-stage1 || { exit 1; }

## Configure the build.
../configure --prefix="$HSDEV/$TARGET" --enable-obsolete --target="$TARGET" --with-endian=little --enable-languages="c" --with-newlib --disable-libssp --without-headers $TARG_XTRA_OPTS || { exit 1; }

## Compile and install.
make clean && make -j $PROC_NR && make install && make clean || { exit 1; }

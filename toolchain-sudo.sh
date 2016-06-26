#!/bin/bash
# based on toolchain.sh by Naomi Peori (naomi@peori.ca)
# modified by Rafał Kołucki <BluRaf@gmx.com>

## Enter the hstoolchain directory.
cd "`dirname $0`" || { echo "ERROR: Could not enter the hstoolchain directory."; exit 1; }

## Set up the environment.
export HSDEV=/opt/hsdev
export HSSDK=$HSDEV/hssdk
export PATH=$PATH:$HSDEV/bin
export PATH=$PATH:$HSSDK/bin

## Run the toolchain script.
./toolchain.sh $@ || { echo "ERROR: Could not run the toolchain script."; exit 1; }

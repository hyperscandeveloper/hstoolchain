#!/bin/sh
# based on check-pspdev.sh by Naomi Peori (naomi@peori.ca)
# modified by Rafał Kołucki <BluRaf@gmx.com>

## Check if $HSDEV is set.
if test ! $HSDEV; then { echo "ERROR: Set \$HSDEV before continuing."; exit 1; } fi

## Check for the $HSDEV directory.
ls -ld $HSDEV 1> /dev/null || mkdir -p $HSDEV 1> /dev/null || { echo "ERROR: Create $HSDEV before continuing."; exit 1; }

## Check for $HSDEV write permission.
touch $HSDEV/test.tmp 1> /dev/null || { echo "ERROR: Grant write permissions for $HSDEV before continuing."; exit 1; }

## Check for $HSDEV/bin in the path.
echo $PATH | grep $HSDEV/bin 1> /dev/null || { echo "ERROR: Add $HSDEV/bin to your path before continuing."; exit 1; }

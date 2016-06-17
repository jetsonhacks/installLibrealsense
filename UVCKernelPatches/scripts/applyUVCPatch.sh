#!/bin/bash
# Apply the UVC patches need for Realsense cameras
PATCHDIR=$PWD
cd /usr/src/kernel
echo $PATCHDIR
patch -p 4 -i $PATCHDIR/patchUVCDriver.diff
patch -p 4 -i $PATCHDIR/patchUVCInclude.diff




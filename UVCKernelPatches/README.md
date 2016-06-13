This directory contains patches for L4T 21.4 on the NVIDIA Jetson TK1 
to support Intel Realsense cameras. You will need to build a new kernel. 
This document assumes that you know how to build a kernel for the TK1, similar to the instructions at:

https://devtalk.nvidia.com/default/topic/762653/-howto-build-own-kernel-for-jetson-tk1/

The default kernel has uvcvideo built-in. The file 'dotConfig' converts uvcvideo into a module, and retains the same kernel local-version identifier:

-gdacac96

as the stock L4T 21.4 kernel. The file 'dotConfig' is the .config file that is modified
as described (it can be used as the .config in the kernel directory assuming no other 
changes to the kernel are needed).

Download the kernel source and decompress it into /usr/src
You can then apply the patches from the /usr/src/kernel directory similar to:

\# Switch to /usr/src/kernel<br>
\# Try a dry run first by adding --dry-run flag to the patch command
 
patch -p 4 -i \<Patched files\>/patchUVCDriver.diff<br>
patch -p 4 -i \<Patched files\>/patchUVCInclude.diff

where \<Patched files\> represents the path to where the patches are stored. 

Note: The folder 'Patched Files' in this directory holds copies of the files
(after patches applied) that are patched in the above process.

Once the patches are applied, make the kernel and the modules:

<code>
make prepare<br>
make modules_prepare<br>
make -j4<br>
make modules<br>
make modules_install<br>
</code>

You can save the zImage for flashing on the TK1 from a host computer. You can also copy the zImage
to the boot directory:

sudo cp arch/arm/boot/zImage /boot/zImage

which will cause the new kernel to be used on boot. 

In order to have uvcvideo.ko loaded at boot time, in the file:

/etc/modules

add the line: 

uvcvideo

This will load the uvcvideo driver at boot time.

In the case where the zImage was copied to the boot directory, rebooting the machine
will cause the new kernel and modules to be used.




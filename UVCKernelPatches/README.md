This directory contains patches for L4T 21.4 on the NVIDIA Jetson TK1 
to support Intel RealSense cameras. You will need to build a new kernel.
Please read through this document before altering your system.
 
This document assumes that you know how to build a kernel for the TK1, similar to the instructions at:

https://devtalk.nvidia.com/default/topic/762653/-howto-build-own-kernel-for-jetson-tk1/

To start, download the kernel source and decompress it into /usr/src

The kernel sources for L4T 21.4 are available at:

https://developer.nvidia.com/linux-tegra-r214

Note: 

There is a convenience script provided for downloading the kernel source (this will also open a configuration editor): 

$ ./getKernelSources.sh


<strong>USB Video Class (UVC)</strong>

The RealSense libraries adds configuration information to the UVC device driver. This directory contains patches for the stock 3.10 kernel sources to integrate those changes. 

This document describes creating a UVC module called 'uvcvideo.ko'

The default kernel has uvcvideo built-in. As a convenience, the file 'dotConfig' is a .config file which configures the kernel to use uvcvideo as a module, and retains the same kernel local-version identifier:

-gdacac96

as the stock L4T 21.4 kernel. The file 'dotConfig' is the .config file that is modified
as described (it can be used as the .config in the kernel directory assuming no other 
changes to the kernel are needed).

The settings in the kernel config file for uvcvideo is:

Device Drivers->Multimedia support->Media USB Adapters->USB Video Class(UVC)

Set this to build as a module


You can then apply the UVC patches similar to:

\# Switch to /usr/src/kernel<br>
\# Try a dry run first by adding --dry-run flag to the patch command
 
$ patch -p 4 -i \<Patched files\>/patchUVCDriver.diff<br>
$ patch -p 4 -i \<Patched files\>/patchUVCInclude.diff

where \<Patched files\> represents the path to where the patches are stored, i.e this directory. 

Note: The folder 'Patched Files' in this directory holds copies of the files
(after patches applied) that are patched in the above process.

Note that a convenience file is provide to do the above steps.

$ ./applyUVCPatch.sh

Once the patches are applied, make the kernel and the modules:

<blockquote>
make prepare <br />
make modules_prepare <br />
make -j4  <br />
make modules <br />
make modules_install <br />
</blockquote>

Note that a convenience file is provided for the above steps:

$ ./buildKernel.sh

After the build is complete, you can save the zImage for flashing on the TK1 to external media. This image can then be used to flash the Jetson with the new configuration. 

You can copy the zImage to the boot directory:

$ sudo cp arch/arm/boot/zImage /boot/zImage

which will cause the new kernel to be used on boot. 

In order to have uvcvideo.ko load at boot time, in the file:

/etc/modules

add the line: 

uvcvideo

This will load the uvcvideo driver at boot time.

A convenience file is provided to copy the zImage and add the module name to /etc/modules :

$ ./copyzImage.sh

In the case where the zImage was copied to the boot directory, rebooting the Jetson
will cause the new kernel and modules to be used.




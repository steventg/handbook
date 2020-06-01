## Adding MFC-240C Printer to Raspberry Pi

Brother provides the LPR and CUPS drivers but they are only in i386 architecture.

# Pre-req
1. Install CUPS

# Download and Install the Linux driver (.deb)
http://support.brother.com/g/b/downloadlist.aspx?c=us&lang=en&prod=mfc240c_all&os=128

```
dpkg -i --force-all mfc240clpr-1.0.1-1.i386.deb
dpkg -i --force-all mfc240ccupswrapper-1.0.1-1.i386.deb
```

Note: The installation will fail complaining some directories were not created.
Create them and re-run again.

# Install QEMU
https://wiki.debian.org/QemuUserEmulation
1. ```apt-get install qemu binfmt-support qemu-user-static```
2. ```update-binfmts --display```

3. ```sudo dpkg --add-architecture armhf```

4. ```sudo sysctl -w vm.mmap_min_addr="0"``` # maybe not needed

5. Download https://packages.debian.org/jessie/i386/libc6-udeb/download
6. ```dpkg -i libc6_2.13-38+deb7u8_i386.deb```
  

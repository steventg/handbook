## Fix /etc/crypttab

1. Boot with Ubuntu 20.04 
1. ```sudo modprobe dm-crypt```
1. ```sudo fdisk -l```
1. ```sudo cryptsetup luksOpen /dev/nvme0n1p3```
1. ```sudo vgchange -ay```
1. Mount the disk 
    ```
    sudo mount /dev/mapper/ubuntu-vg-root /mnt
    sudo mount /dev/nvme0n1p2 /mnt/boot
    sudo mount --bind /dev /mnt/dev 
    sudo mount --bind /dev/pts /mnt/dev/pts
    sudo mount --bind /proc /mnt/proc
    sudo mount --bind /sys /mnt/sys
    ```
1. Chroot and Update
    1. ```sudo chroot /mnt```
    1. Fix /etc/crypttab
    1. ```update-initramfs -c -k all```

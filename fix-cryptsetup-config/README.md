## Save Keyfile in /boot
1. Create a Luks keyfile
    ```
    sudo dd if=/dev/urandom of=/boot/keyfile bs=1024 count=4
    sudo chmod 0400 /boot/keyfile
    cryptsetup -v luksAddKey /dev/sda3 /boot/keyfile
    ````
 1. Update `/etc/crypttab`
    ```
    nvme0n1p3_crypt UUID=<UUID of /> /dev/disk/by-uuid/<UUID of /boot>:/boot/keyfile luks,keyscript=/lib/cryptsetup/scripts/passdev
    ```
 
 1. ```sudo update-initramfs -u & sudo reboot```
 
 ## Save Keyfile in a USB drive
 https://askubuntu.com/questions/59487/how-to-configure-lvm-luks-to-autodecrypt-partition

 
## Fix /etc/crypttab

1. Boot with Ubuntu 20.04 Live USB
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

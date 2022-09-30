See the [official Nix guide][guide].

1. [Update the bootloader][bootloader]
2. Create an SD image using [nixos-docker-sd-image-builder][image-builder]
    - Add your SSH key and wireless network in config/sd-image.nix
3. Boot from the SD card
4. Check router for IP address and ssh into Pi
5. `sudo -i` to get a root shell for the rest of the boot process
6. Update the firmware
    - `nix-shell -p raspberrypi-eeprom`
    - `mount /dev/disk/by-label/FIRMWARE /mnt`
    - `BOOTFS=/mnt FIRMWARE_RELEASE_STATUS=stable rpi-eeprom-update -d -a`
7. Partition and format the SSD
    - `parted /dev/sda -- mklabel gpt`
    - `parted /dev/sda -- mkpart primary 0% -8G`
    - `parted /dev/sda -- mkpart primary linux-swap -8G 100%`
    - `mkfs.ext4 -L ETHEREUM /dev/sda1`
    - `mkswap -L SWAP /dev/sda2`
8. Clone the flake repository to `/etc/nixos` and then `nixos-rebuild switch --flake /etc/nixos#eth-nix`
9. `reboot`
10. Continue with [SETUP.md](./SETUP.md)

[guide]: https://nixos.org/guides/installing-nixos-on-a-raspberry-pi.html
[bootloader]: https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#updating-the-bootloader
[image-builder]: https://github.com/Robertof/nixos-docker-sd-image-builder

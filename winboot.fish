#!/usr/bin/fish
# Reboot into Windows 11 from CachyOS
# Usage: Run this from Steam

sudo efibootmgr --bootnext 0003
sudo reboot

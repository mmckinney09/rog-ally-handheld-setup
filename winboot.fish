#!/usr/bin/fish
# Reboot into Windows 11 from CachyOS
# Usage: Run this from Steam
# Replace 0003 with your actual Windows boot number

sudo efibootmgr --bootnext 0003
sudo reboot

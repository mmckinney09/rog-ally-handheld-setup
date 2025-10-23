# Dual-Boot Windows 11 Reboot Script for CachyOS (ROG Ally)

This guide creates a **passwordless reboot script** that lets you boot directly into **Windows 11** from **CachyOS Handheld Edition**—perfect for ROG Ally users who dual-boot and want seamless switching (like the Bazzite method from [Overkill Digest #67](https://overkill.wtf/digest-67/)).

> ✅ Works with **Fish shell**  
> ✅ No password prompt when launched from Steam
> ✅ Safe EFI boot management via `efibootmgr`

---

## 🔧 Step 1: Identify Your Windows Boot Entry

Open a terminal in CachyOS and run:

```fish
sudo efibootmgr
```
Look for a line like:
```
Boot0003* Windows Boot Manager
```
Note the 4-digit hex ID (e.g., 0003). You’ll use this in the script.
## 📜 Step 2: Create the Reboot Script
```
mkdir -p ~/.local/bin
nano ~/.local/bin/winboot.fish
```
Paste the following (replace 0003 with your actual boot number):
```
#!/usr/bin/fish
# Reboot into Windows 11 from CachyOS
sudo efibootmgr --bootnext 0003
sudo reboot
```
Save and exit:

Ctrl+O → Enter (write file)
Ctrl+X (exit)
Make it executable:
```
chmod +x ~/.local/bin/winboot.fish
```
Ensure ~/.local/bin is in your PATH:
```
set -U fish_user_paths ~/.local/bin $fish_user_paths
```
🔒 Step 3: Allow Passwordless sudo
Run:
```
sudo EDITOR=nano visudo -f /etc/sudoers.d/winboot
```
Add this line (CachyOS uses the wheel group by default):
```
%wheel ALL=(ALL) NOPASSWD: /usr/bin/efibootmgr, /usr/bin/reboot
```
Save (Ctrl+O, Enter, Ctrl+X).

⚠️ Always use visudo—never edit sudoers files directly! 

🎮 Step 4: Add to Steam
In Steam:

Games > Add a Non-Steam Game

Click Browse and select:

~/.local/bin/winboot.fish

Launching it will immediately reboot into Windows 11.

🔁 Return to CachyOS

Just restart Windows normally. Your system will boot back into CachyOS (assuming it’s still the default EFI entry).

To verify or reset the boot order:
```
sudo efibootmgr          # Find your CachyOS entry (e.g., Boot0001)
sudo efibootmgr --bootorder 0001,0003
```
✅ Test It
Run this to confirm no password is needed:
```
sudo efibootmgr --bootnext 0003
```
If it executes silently—you’re good to go!




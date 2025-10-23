Setup Remote SMB Share on CachyOS (Fish Shell)
This guide mounts a remote SMB/CIFS share to /data on CachyOS using the Fish shell.

✅ Tested on CachyOS Handheld Edition (Arch-based) with Fish as the default shell. 


1. Create Local Mount Point and Set Ownership
```
sudo mkdir -p /data; and sudo chown $USER:$USER /data
```
* mkdir -p ensures no error if /data already exists.
* In Fish, ; and runs the second command only if the first succeeds (equivalent to && in Bash).

2. Install CIFS Utilities
```
sudo pacman -S cifs-utils --needed
```
3. Create SMB Credentials File

Create a secure credentials file:
```
sudo nano /etc/smbcreds
```
Add your SMB credentials (replace values):
```
username=your_smb_username
password=your_smb_password
```
Secure the file:
```
sudo chmod 600 /etc/smbcreds
```
4. Configure /etc/fstab for Auto-Mount

Edit fstab:
```
sudo nano /etc/fstab
```
Add this line at the bottom:
```
# Remote SMB Share
//your_ip_address_fileserver/data  /data  cifs  credentials=/etc/smbcreds,uid=1000,gid=1000,iocharset=utf8,vers=3.0,dir_mode=0777,file_mode=0777  0  0
```
5. Mount the Share
Reload and mount:
```
sudo systemctl daemon-reload; and sudo mount -a
```
If you get a "mount error(22)", check SMB version compatibility or network connectivity. 

6. Verify
Check if mounted:
```
df -h | grep /data
ls -l /data
```


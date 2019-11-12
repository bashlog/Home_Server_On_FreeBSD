# 
# ================= create zfs dataPool pool ========================
# camcontrol devlist
ls /dev
echo "Please input disk device"
set disk=$<
zpool create -f dataPool $disk
zfs create dataPool/BrightAlan
zfs create -o compress=lz4 dataPool/BrightAlan/Backups
zfs create dataPool/BrightAlan/Video
zfs list


# ==================== enable zfs server=============================
sysrc zfs_enable="YES"


# ============= add Samba Share User (System User) ==================
pw groupadd sambaShare -g 2000
pw adduser BrightAlan -u 2000 -g sambaShare -d /nonexistent -s /usr/sbin/nologin
pw adduser q -u 2001 -g sambaShare -d /nonexistent -s /usr/sbin/nologin


# add Samba Server User
echo "pleasr input user BrightAlan's password"
smbpasswd -a BrightAlan
echo "pleasr input user q's password"
smbpasswd -a q 


# change Share dir pre
chown -R BrightAlan:sambaShare /dataPool/BrightAlan


# enable samba server
sysrc samba_server_enable="YES"
#!/bin/bash
# variant speciffic code
# it will get executed inside chroot, after all packages are installed
# you can assume variant resources are in /resources

# creating/updadeing icon caches
find /usr/share/icons -maxdepth 1 -type d|grep -vx "/usr/share/icons"|while read icon;
do
    gtk-update-icon-cache $icon
done

# run the ubiquity installer with sudo
sed -i s/"Exec.*"/"Exec=sudo sh -c 'ubiquity gtk_ui'"/g /usr/share/applications/ubiquity.desktop

# let NetworkManager manage the network connections
sed -i s/"managed=.*"/"managed=true"/g /etc/NetworkManager/NetworkManager.conf

# the user can't reboot/shutdown/hybernate without this
echo "session required pam_systemd.so" >>/etc/pam.d/lxdm

# set the timezone to Europe/Bucharest
cat /usr/share/zoneinfo/Europe/Bucharest >/etc/localtime

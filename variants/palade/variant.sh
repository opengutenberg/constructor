#!/bin/bash
# variant speciffic code
# it will get executed inside chroot

# creating/updadeing icon caches
find /usr/share/icons -maxdepth 1 -type d|grep -vx "/usr/share/icons"|while read icon;
do
    gtk-update-icon-cache $icon
done

# FIXME: WHY does this file get overwritten ? i copy resources/* after all the customizations...
mv -f /etc/lxdm/lxdm.conf.dpkg-dist /etc/lxdm/lxdm.conf

# run the ubiquity installer with sudo
sed -i s/"Exec.*"/"Exec=sudo sh -c 'ubiquity gtk_ui'"/g /usr/share/applications/ubiquity.desktop

# the user can't reboot/shutdown/hybernate without this
echo "session required pam_systemd.so" >>/etc/pam.d/lxdm

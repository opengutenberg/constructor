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

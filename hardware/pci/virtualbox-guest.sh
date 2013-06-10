#!/usr/bin/env bash

pacman -S --needed --noconfirm virtualbox-guest-utils
echo "vboxguest" >  /etc/modules-load.d/virtualbox-guest.conf
echo "vboxsf"    >> /etc/modules-load.d/virtualbox-guest.conf
echo "vboxvideo" >> /etc/modules-load.d/virtualbox-guest.conf
echo "Press a key:"
read

# Synchronise date/time to the host
if [ "${HOSTNAME}" != "archiso" ]; then
    # Only do this when  NOT running from the install media
    modprobe -a vboxguest vboxsf vboxvideo
    gpasswd -a ${SUDO_USER} vboxsf
    systemctl stop openntpd
    systemctl start vboxservice
fi
systemctl disable openntpd
systemctl enable vboxservice
echo "Press a key:"
read

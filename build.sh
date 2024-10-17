#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree override remove \
    gnome-classic-session \
	gnome-classic-session-xsession \
    gnome-shell-extension-apps-menu \
    gnome-shell-extension-launch-new-instance \
    gnome-shell-extension-places-menu \
    gnome-shell-extension-window-list \
    gnome-shell-extension-background-logo

rpm-ostree install \ # repos
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm 

rpm-ostree install \ # extensions
    gnome-shell-theme-yaru \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-no-overview \
    gnome-shell-extension-dash-to-dock \
    gnome-shell-extension-user-theme \
    gnome-shell-extension-drive-menu

rpm-ostree install \ # apps
    gcc \
    gnome-tweaks \
    make \
    opendyslexic-fonts \
    samba

systemctl enable dconf-update.service
systemctl enable flatpak-add-flathub-repo.service
systemctl enable flatpak-replace-fedora-apps.service
systemctl enable flatpak-cleanup.timer

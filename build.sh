#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

rpm-ostree override remove \
    gnome-classic-session \
	gnome-classic-session-xsession \
    gnome-shell-extension-apps-menu \
    gnome-shell-extension-launch-new-instance \
    gnome-shell-extension-places-menu \
    gnome-shell-extension-window-list \
    gnome-shell-extension-background-logo

# repos
rpm-ostree install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm 

# extensions
rpm-ostree install \
    gnome-shell-theme-yaru \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-no-overview \
    gnome-shell-extension-dash-to-dock \
    gnome-shell-extension-user-theme \
    gnome-shell-extension-drive-menu

# programs
rpm-ostree install \
    gcc \
    gnome-tweaks \
    make \
    opendyslexic-fonts \
    samba

# services
systemctl enable dconf-update.service
systemctl enable flatpak-add-flathub-repo.service
systemctl enable flatpak-replace-fedora-apps.service
systemctl enable flatpak-cleanup.timer
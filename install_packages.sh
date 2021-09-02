#!/bin/bash

shopt -s nocasematch

base="ranger atool stow python figlet zsh zsh-syntax-highlighting ffmpeg neofetch \
htop lynx mediainfo vim ncdu openssh syncthing tmux wget youtube-dl"

base_aur="lsd-git"

gui="rofi rofi-calc networkmanager network-manager-applet firefox thunderbird \
herbstluftwm blueman flameshot dunst udiskie mpv redshift xclip slop \
imagemagick capitaine-cursors arc-icon-theme code feh filezilla noto-fonts \
noto-fonts-cjk noto-fonts-emoji noto-fonts-extra numlockx obs-studio pavucontrol \
xsensors pulseaudio pulseaudio-alsa pulseaudio-bluetooth zenity xorg-xinit xorg"

gui_aur="rxvt-unicode-intensityfix dragon-drag-and-drop i3lock-color tauon-music-box matcha-gtk-theme logiops \
liri-calculator neovim-nightly-bin nerd-fonts-complete obs-studio qimgv-git qmk-git syncplay-git \
compton-tryone-git polybar"

gaming="discord-canary steam"

gaming_aur="multimc5"

extras="convmv hexchat kcolorchooser mkvtoolnix-gui mkvtoolnix-cli"

extras_aur="lazygit-git mp3tag megatools-bin mumble python-bdfr"


echo -en "\nInstall paru? [Y/n]:  "
read -n 1 install_paru
install_paru=${install_paru:-y}


echo -e "\n$base"
echo -en "\nInstall Base packages? [Y/n]:  "
read -n 1 install_base
install_base=${install_base:-y}

if [[ $install_paru == "y" ]]; then
    echo -e "\n$base_aur"
    echo -en "\nInstall Base AUR packages? [Y/n]:  "
    read -n 1 install_base_aur
    install_base_aur=${install_base_aur:-y}
fi

echo -e "\n$gui"
echo -en "\nInstall GUI packages? [Y/n]:  "
read -n 1 install_gui
install_gui=${install_gui:-y}

if [[ $install_paru == "y" ]]; then
    echo -e "\n$gui_aur"
    echo -en "\nInstall GUI AUR packages? [Y/n]:  "
    read -n 1 install_gui_aur
    install_gui_aur=${install_gui_aur:-y}
fi


echo -en "\nInstall Telegram? [Y/n]:  "
read -n 1 install_telegram
install_telegram=${install_telegram:-y}


echo -e "\n$gaming"
echo -en "\nInstall gaming packages? [y/N]:  "
read -n 1 install_gaming
install_gaming=${install_gaming:-n}

if [[ $install_paru == "y" ]]; then
    echo -e "\n$gaming_aur"
    echo -en "\nInstall gaming AUR packages? [y/N]:  "
    read -n 1 install_gaming_aur
    install_gaming_aur=${install_gaming_aur:-n}
fi


echo -e "\n$extras"
echo -en "\nInstall extra packages? [y/N]:  "
read -n 1 install_extras
install_extras=${install_extras:-n}

if [[ $install_paru == "y" ]]; then
    echo -e "\n$extras_aur"
    echo -en "\nInstall extra AUR packages? [y/N]:  "
    read -n 1 install_extras_aur
    install_extras_aur=${install_extras_aur:-n}
fi


if [[ $install_base == "y" ]]; then
    packages+="$base "
fi

if [[ $install_gui == "y" ]]; then
    packages+="$gui "
fi

if [[ $install_gaming == "y" ]]; then
    packages+="$gaming "
fi

if [[ $install_extras == "y" ]]; then
    packages+="$extras "
fi


if [[ $install_telegram == "y" && -e /usr/bin/paru ]]; then
    paru -Sy nix-bin
    systemctl enable --now nix-daemon.socket
    source /etc/profile.d/nix-daemon.sh
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable
    nix-channel --update
    nix-env -iA nixpkgs.tdesktop
    ls ~/.nix-profile/bin
    [ -f /etc/profile.d/nix.sh ] && source /etc/profile.d/nix.sh
fi


echo "Installing packages: $packages"
sudo pacman -Syu --needed $packages


if [[ $install_paru == "n" ]]; then
    exit
fi

sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
makepkg -si

packages = ""
if [[ $install_base_aur == "y" ]]; then
    packages+="$base_aur "
fi

if [[ $install_gui_aur == "y" ]]; then
    packages+="$gui_aur "
fi

if [[ $install_gaming_aur == "y" ]]; then
    packages+="$gaming_aur "
fi

if [[ $install_extras_aur == "y" ]]; then
    packages+="$extras_aur "
fi


echo "Packages: $packages"
paru -Syu --needed $packages

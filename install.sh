#!/usr/bin/env bash

set -eu -o pipefail

DIR="$(cd "$(dirname "$0")"; pwd)"
echo $DIR

install_tmux_config() {
    echo "Installing config file"
}

if uname -a | grep -qi 'Ubuntu'; then
    echo "Ubuntu detected"

    echo "Updating package list"
    DEBIAN_FRONTEND=noninteractive sudo apt-get -y update

    echo "Installing htop"
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y htop

    echo "Installing git"
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y git

    echo "Installing zsh"
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y zsh

    echo "Setting zsh as default shell"
    sudo chsh -s "$(which zsh)" "$(whoami)"

    echo 'Installing powerline-fonts...'

    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts

    echo 'Installing tmux...'
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y tmux

    echo 'Installing neovim...'
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y software-properties-common
    DEBIAN_FRONTEND=noninteractive sudo add-apt-repository -y ppa:neovim-ppa/unstable
    DEBIAN_FRONTEND=noninteractive sudo apt-get update -y
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y neovim

fi

if uname -a | grep -qi 'ARCH'; then
    echo "Arch Linux detected"

    echo "Updating pacman database"
    sudo pacman -Syy

    echo "Installing htop"
    sudo pacman -S --noconfirm htop

    echo "Installing git"
    sudo pacman -S --noconfirm git

    echo "Installing zsh"
    sudo pacman -S --noconfirm zsh

    echo "Setting zsh as default shell"
    sudo chsh -s "$(which zsh)" "$(whoami)"

    echo 'Installing powerline-fonts...'

    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts

    echo 'Installing tmux...'
    sudo pacman -S --noconfirm tmux

fi

install_tmux_config


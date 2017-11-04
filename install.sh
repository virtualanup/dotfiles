#!/usr/bin/env bash

set -eu -o pipefail

DIR="$(cd "$(dirname "$0")"; pwd)"
echo $DIR

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
fi

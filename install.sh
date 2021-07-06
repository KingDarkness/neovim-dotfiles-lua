#!/usr/bin/env bash

get_platform() {
    case "$(uname -s)" in
        Linux*) platform=Linux ;;
        Darwin*) platform=Mac ;;
        CYGWIN*) platform=Cygwin ;;
        MINGW*) platform=MinGw ;;
        *) platform="UNKNOWN:${unameOut}" ;;
    esac
    echo $platform
}

if [[ ! -e ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]]; then
    echo "Installing packer"
    git clone https://github.com/wbthomason/packer.nvim \
        ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

echo "Install dependency app"
APT_GET_CMD=$(which apt-get)
BREW=$(which brew)

if [[ ! -z $APT_GET_CMD ]]; then
    apt-get install -y ripgrep bat fd-find silversearcher-ag
elif [[ ! -z BREW ]]; then
    brew install ripgrep bat fd editorconfig luajit tree-sitter the_silver_searcher
else
    echo "error can't find package manager"
    exit 1
fi

echo "Install formmater"
chmod a+x ~/.config/nvim/plugins/install-formatter.sh
sh -c ~/.config/nvim/plugins/install-formatter.sh

echo "Open vim install packer"
nvim +PackerInstall

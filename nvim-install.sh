#!/bin/sh

if [ -z "$PROMPT" ]; then
    read -p "Running this script will erase your current neovim configuration, are you sure you want to continue? [Y/n]: " prompt
else
    prompt="$PROMPT"
fi

prompt="${prompt:-Y}"
prompt=$(echo "$prompt" | tr '[:upper:]' '[:lower:]')

if [ "$prompt" = "y" ]; then
    if [ -d "$HOME/.config/nvim" ]; then
        rm -rf "$HOME/.config/nvim"
    fi

    git clone https://github.com/akirakani-kei/nvim-conf
    mv nvim-conf nvim
    mv nvim ~/.config
    rm ~/.config/nvim/autoload/plug.vim  # removes backup
    wget https://raw.githubusercontent.com/junegunn/vim-plug/refs/heads/master/plug.vim -P ~/.config/nvim/autoload  # gets the latest version of vim-plug
    rm ~/.config/nvim/nvim-install.sh  # removes redundant install script

else
    echo "aborting."
    exit 1
fi

exit 0

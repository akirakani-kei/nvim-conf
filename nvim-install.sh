#!/bin/sh

read -r -p "Running this script will erase your current neovim configuration, are you sure you want to continue? [y/N]: " response
response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
if [ "$response" = "y" ] || [ "$response" = "yes" ]; then

	if [ -d "$HOME/.config/nvim" ]; then
            rm -rf "$HOME/.config/nvim"
        fi

        git clone https://github.com/akirakani-kei/nvim-conf
        mv nvim-conf nvim
        mv nvim ~/.config
	rm ~/.config/nvim/autoload/plug.vim	# removes backup
	wget https://raw.githubusercontent.com/junegunn/vim-plug/refs/heads/master/plug.vim -P ~/.config/nvim/autoload	#gets the latest version of vim-plug
        rm ~/.config/nvim/nvim-install.sh	# removes redundant install script
	nvim +'PlugInstall --sync'

	exit 0

fi

echo "aborting."
exit 1

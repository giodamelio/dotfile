#!/bin/bash

# Hack to make my dotfiles in Github Codespaces
# Install stow and remove some conflicting config files
if [ "$CODESPACES" == "true" ]; then
    apt-get -y install --no-install-recommends stow
    
    rm ~/.gitconfig
    rm ~/.bashrc
fi

stow */


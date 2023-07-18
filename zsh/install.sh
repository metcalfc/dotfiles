#!/bin/bash

if [ ! -d "${HOME}/.zgenom" ]; then
    git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

# Check for Homebrew
if test ! $(which brew)
then
    brew install starship
fi

if [ ! -d "${HOME}/.config" ]; then
    mkdir "${HOME}/.config"
fi

if [ ! -f "${HOME}/.config/starship.toml" ]; then
    ln -s "${DOTFILES}/zsh/starship.toml" "${HOME}/.config/starship.toml"
fi


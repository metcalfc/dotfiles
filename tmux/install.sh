#!/bin/bash

# Check for Homebrew
if test $(which brew)
then
    brew install tmux
fi

# check if tmux plugin manager is installed and install if not
if [ ! -d "${HOME}/.config/tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi

# check if ~/.config/tmux.conf exists and create a symlink to the one in this repo if not
if [ ! -L "${HOME}/.config/tmux.conf" ]; then
    ln -s "${DOTFILES}/tmux/tmux.conf" "${HOME}/.config/tmux/tmux.conf"
fi

exit 0

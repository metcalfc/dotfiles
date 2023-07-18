#!/bin/bash

if [ ! -d "${HOME}/.zgenom" ]; then
    git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

# Check for Homebrew
if test ! $(which brew)
then
    brew install starship
fi

exit 0



#!/bin/bash

# Check for Homebrew
if test ! $(which brew)
then
    brew install powerline-go
fi

if [ ! -d "${HOME}/.zgenom" ]; then
    git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

exit 0



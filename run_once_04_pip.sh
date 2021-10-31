#!/bin/bash

if command -v pip3 &> /dev/null
then
    python3 -m pip install --upgrade pip
    python3 -m pip install --user --upgrade neovim
fi

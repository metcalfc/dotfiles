#!/bin/bash

# Check for Homebrew
if test ! $(which brew)
then
    brew install coreutils
fi

exit 0



#!/bin/bash

if [ ! -d "${HOME}/.zgenom" ]; then
  git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

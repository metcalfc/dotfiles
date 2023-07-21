#!/bin/bash

# Check for Homebrew
if test "$(which brew)"
then
    brew install coreutils keychain
fi

if [[ -n "${WSL_DISTRO_NAME}" ]]; then
  if [ ! -e "bin/npiperelay.exe" ]; then
    FILE="npiperelay_windows_amd64.zip"
    NPIPERELAY="https://github.com/jstarks/npiperelay/releases/download/v0.1.0/${FILE}"
    SHA="6b9ef61ffd17c03507a9a3d54d815dceb3dae669ac67fc3bf4225d1e764ce5f6"
    curl --location --show-error --silent --output "${FILE}" "${NPIPERELAY}" &&
    echo "${SHA} ${FILE}" | sha256sum --check --quiet &&
    unzip -q -p "${FILE}" npiperelay.exe > bin/npiperelay.exe &&
    chmod +x bin/npiperelay.exe &&
    rm "${FILE}"
  fi
fi
exit 0



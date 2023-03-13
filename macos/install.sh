if test ! "$(uname)" = "Darwin"
  then
  exit 0
fi

# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.

echo "› sudo softwareupdate -i -a"
sudo softwareupdate -i -a

# Check for Homebrew
if test ! $(which brew)
then
  brew bundle --file=/dev/stdin <<EOF
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-fonts"

brew "brew-cask-completion"
brew "cask"
brew "dive"
brew "hopenpgp-tools"
brew "mas"
brew "pinentry-mac"
brew "pinentry"
brew "python3"
brew "reattach-to-user-namespace"
brew "ykman"
brew "yubikey-personalization"
cask "1password-cli"
cask "1password"
cask "docker"
cask "font-awesome-terminal-fonts"
cask "font-fira-code"
cask "github"
cask "google-chrome"
cask "iterm2"
cask "slack"
cask "visual-studio-code"
cask "vlc"
cask "zoom"

#mas "Amphetamine", id: 937984704
#mas "Moom", id: 419330170
#mas "Paprika Recipe Manager 3", id: 1303222628
#mas "Unsplash Wallpapers", id: 1284863847
#mas "Webcam Settings", id: 533696630
#mas "Microsoft Remote Desktop", id: 1295203466
EOF
fi

function gome () {
  # Check for Homebrew
  if (( $+commands[brew] ))
  then
      brew install go goreleaser
  fi
}
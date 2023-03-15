if [ -d "/opt/homebrew/bin" ]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

function brewme () {
  # Ensure essential bundles are installed on Linux and Mac
  brew install "git" \
   "nvim" \
   "coreutils" \
   "fzf" \
   "git" \
   "gh" \
   "jq" \
   "shellcheck" \
   "ssh-copy-id" \
   "tmux" \
   "wget" \
   "zsh" \
   "zsh-completions" \
   "zsh-syntax-highlighting"

}
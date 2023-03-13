# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

if [[ "$ITERM_PROFILE" =~ ^(solarized)+ ]]; then
    #https://github.com/seebi/dircolors-solarized/issues/10
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
fi
if [[ "$ITERM_PROFILE" =~ ^(gruvbox)+ ]]; then
    export LSCOLORS=ExFxCxDxBxegedabagacad
fi

# use gnu dircolors
if [ -x `whence -p gdircolors` ]; then alias dircolors='gdircolors'; fi
eval `dircolors --sh ${DOTFILES}/colors/gruvbox.dircolors`

# enable ls colors for zsh completion
if [ -x `whence -p gls` ]; then alias ls='gls --color=auto'; fi
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

if [[ -f ${DOTFILES}/../colors/gruvbox_256palette_osx.sh ]]; then
    source ${DOTFILES}/colors/gruvbox_256palette_osx.sh
fi

# Setup fzf
# ---------
if [[ ! "$PATH" == */home/linuxbrew/.linuxbrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$(brew --prefix)/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

# Use Atuin to search history with fzf
# Found: https://github.com/ellie/atuin/issues/68#issuecomment-1585444955
atuin-setup() {
        if ! which atuin &> /dev/null; then return 1; fi
        bindkey '^E' _atuin_search_widget

        export ATUIN_NOBIND="true"
        eval "$(atuin init zsh)"
        fzf-atuin-history-widget() {
            local selected num
            setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2>/dev/null

            # local atuin_opts="--cmd-only --limit ${ATUIN_LIMIT:-5000}"
            local atuin_opts="--cmd-only"
            local fzf_opts=(
                --height=${FZF_TMUX_HEIGHT:-80%}
                --tac
                "-n2..,.."
                --tiebreak=index
                "--query=${LBUFFER}"
                "+m"
                "--bind=ctrl-d:reload(atuin search $atuin_opts -c $PWD),ctrl-r:reload(atuin search $atuin_opts)"
            )

            selected=$(
                eval "atuin search ${atuin_opts}" |
                    fzf "${fzf_opts[@]}"
            )
            local ret=$?
            if [ -n "$selected" ]; then
                # the += lets it insert at current pos instead of replacing
                LBUFFER+="${selected}"
            fi
            zle reset-prompt
            return $ret
        }
        zle -N fzf-atuin-history-widget
        bindkey '^R' fzf-atuin-history-widget
    }
atuin-setup
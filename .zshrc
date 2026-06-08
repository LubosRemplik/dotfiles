#
# ~/.zshrc - macOS compatible
#

# ============================================
# FZF Configuration
# ============================================
export FZF_DEFAULT_OPTS="--history=$HOME/.fzf_history"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# ============================================
# Auto-start tmux (comment out if not wanted)
# ============================================
if command -v tmux >/dev/null 2>&1 \
   && [[ $- == *i* ]] \
   && [[ $TERM != screen* && $TERM != tmux* ]] \
   && [ -z "$TMUX" ] \
   && [ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ] \
   && [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then
    exec tmux new-session -A -s lubos
fi

# ============================================
# Editor
# ============================================
export EDITOR='vim'
export VISUAL='vim'
export TERM='xterm-256color'

# ============================================
# History Configuration
# ============================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt inc_append_history     # Add commands as they are typed
setopt hist_ignore_all_dups   # Remove older duplicate entries
setopt hist_reduce_blanks     # Remove superfluous blanks
setopt share_history          # Share history between sessions
setopt no_auto_remove_slash   # Keep trailing slash on completions

# ============================================
# Aliases
# ============================================
alias ls='ls -G'
alias ll='ls -laG'
alias la='ls -aG'

alias grep='grep --color=auto'

# ============================================
# Azure CLI Completion
# ============================================
autoload -U +X bashcompinit && bashcompinit
[ -f "$HOME/.config/az.completion" ] && source "$HOME/.config/az.completion"

# ============================================
# ClaudePHP
# ============================================
claudephp() {
    local setup_git_excludes=false
    local args=()

    while [[ $# -gt 0 ]]; do
        case $1 in
            --setup-git-excludes)
                setup_git_excludes=true
                shift
                ;;
            *)
                args+=("$1")
                shift
                ;;
        esac
    done

    docker run -it --rm \
        -v "$(pwd):/app" \
        -e USER_UID=$(id -u) \
        -e USER_GID=$(id -g) \
        -e SETUP_GIT_EXCLUDES=$setup_git_excludes \
        ghcr.io/hkdevcz/claudephp:8.4 claude "${args[@]}"
}

# ============================================
# Claude session shortcut
# ============================================
claude-session() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: claude-session <title>" >&2
        return 1
    fi
    claude --dangerously-skip-permissions "/session $*"
}

# ============================================
# Prompt (basic - customize or use starship/oh-my-zsh)
# ============================================
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' %F{yellow}(%b)%f'
setopt prompt_subst
PROMPT='%F{green}%n@%m%f %F{blue}%~%f${vcs_info_msg_0_} %# '

# ============================================
# Completions
# ============================================
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive

# ============================================
# Key Bindings
# ============================================
bindkey -e  # Emacs-style bindings
bindkey '^[[A' history-search-backward  # Up arrow
bindkey '^[[B' history-search-forward   # Down arrow
# PATH moved to ~/.zshenv so popups / non-interactive shells get it too
alias glab-hkdev='GLAB_CONFIG_DIR=~/.config/glab-hkdev glab'
alias glab-hkdev='GLAB_CONFIG_DIR=~/.config/glab-hkdev glab'
alias glab-hkdev='GLAB_CONFIG_DIR=~/.config/glab-hkdev glab'

# opencode
export PATH=/Users/lubos/.opencode/bin:$PATH

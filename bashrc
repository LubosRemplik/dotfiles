# Entering tmux https://unix.stackexchange.com/a/113768
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s lubos
fi

# Tmux (possible fix for copy in terminal)
export EDITOR='vim'
export VISUAL='vim'
export TERM='xterm-256color'

# FZF history, use CTRL-P 
export FZF_DEFAULT_OPTS="--history=$HOME/.fzf_history"

# MYSQL default password for containers
export MYSQL_PWD='secret'

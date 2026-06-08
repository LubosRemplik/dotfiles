# Sourced for ALL zsh invocations, including non-login/non-interactive shells
# such as `zsh -c` spawned by tmux display-popup. PATH entries that must be
# available to keybind scripts and popups belong here, not in .zshrc.
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

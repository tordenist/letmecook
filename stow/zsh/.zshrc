# Load Antidote
source $(brew --prefix antidote)/share/antidote/antidote.zsh

# Antidote friendly names for bundles
zstyle ':antidote:bundle' use-friendly-names 'yes'

# Load Antidote Plugins
antidote bundle <~/antidote_plugins.txt >~/.zsh_plugins.zsh
source ~/.zsh_plugins.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Colored ls
alias ls="ls --color=auto"

# Base exports
export ZSH="$HOME"
export ZSH=$(antidote path ohmyzsh/ohmyzsh)
export PATH="/usr/bin/local/bin:$PATH"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Created by `pipx` on 2022-12-06 15:05:59
export PATH="$PATH:/Users/marcello.evangelista/.local/bin"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Powershell
alias powershell="/usr/local/microsoft/powershell/7/pwsh"

# Neovim alias
alias vim=nvim
alias v=nvim

# Zoxide
alias z=zoxide

# Sneaky cat to bat
alias cat=bat

# Shell and prompt integrations
eval "$(starship init zsh)"
eval "$(thefuck --alias)"
eval "$(fzf --zsh)"

# Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Ruby setup w/ rbenv
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

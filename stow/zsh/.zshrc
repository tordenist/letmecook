# Load Antidote
source $(brew --prefix antidote)/share/antidote/antidote.zsh

# Antidote friendly names for bundles
zstyle ':antidote:bundle' use-friendly-names 'yes'

# Load Antidote Plugins
if [[ ! -f ~/.zsh_plugins.zsh || ~/antidote_plugins.txt -nt ~/.zsh_plugins.zsh ]]; then
  antidote bundle <~/antidote_plugins.txt >~/.zsh_plugins.zsh
fi
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

# Load Aliases
[ -f ~/.zshrc_aliases ] && source ~/.zshrc_aliases

# Base exports
export ZSH="$HOME"
export ZSH=$(antidote path ohmyzsh/ohmyzsh)

# Use mise for version management
export PATH="$HOME/.local/share/mise/shims:$HOME/.local/bin:$GOPATH/bin:/opt/homebrew/opt/openjdk/bin:/usr/bin/local/bin:$PATH"
export MISE_TRUSTED_CONFIG_PATHS="$HOME/.config/mise/config.toml:$HOME/grimorium/letmecook/stow/.config/mise/config.toml"
eval "$(mise activate zsh)"
eval "$(mise completion zsh)"

# General PATH setup
export GOPATH="$HOME/go"

# Shell and prompt integrations
eval "$(starship init zsh)"
eval "$(thefuck --alias)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

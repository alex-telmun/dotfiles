# Key bindigs: Emacs mode
bindkey -e

# Remembering recent directories
setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME
## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS
## This reverts the +/- operators.
setopt PUSHD_MINUS

# Help command configuration
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help
# Commands history settings
setopt HIST_IGNORE_DUPS HIST_FIND_NO_DUPS INC_APPEND_HISTORY
HISTSIZE=100000
HISTFILE=~/.zhistfile
SAVEHIST=100000

eval "$(/opt/homebrew/bin/brew shellenv)"

# Autocomplete configuration
fpath+=~/.zshrc.d/zfunc
autoload -Uz compinit && compinit
setopt COMPLETEALIASES
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $(brew --prefix)/bin/mc mc
complete -o nospace -C $(brew --prefix)/bin/terraform terraform
complete -o nospace -C $(brew --prefix)/bin/packer packer
complete -o nospace -C $(brew --prefix)/bin/vault vault
source <(helm completion zsh)

# Load Google Cloud SDK utilites and completions
source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

# $PATH configuration
typeset -U path
path=(~/bin $path[@])

# Load sytax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Load autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Load autopairs
source $(brew --prefix)/share/zsh-autopair/autopair.zsh

# Source included configs
ZSH_CONF_DIR=~/.zshrc.d
typeset -a ZSH_CONF_FILES
ZSH_CONF_FILES=('aliases' 'functions' 'prompt')
for config in ${ZSH_CONF_FILES}
do
  [[ -f "${ZSH_CONF_DIR}/${config}" ]] && . ${ZSH_CONF_DIR}/${config}
done

# Nice system information above prompt
if [[ -f /opt/homebrew/bin/neofetch ]]; then
  neofetch
fi

# ENV settings
export TERM="xterm-256color"
export EDITOR="nvim"
export ALTERNATE_EDITOR="nano"
export VISUAL="nvim"
export PAGER="less"
export GPG_TTY=$(tty)
export PATH=$PATH:/opt/homebrew/bin
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

#export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)

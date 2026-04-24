# OPENSPEC:START
# OpenSpec shell completions — fpath до первого compinit (в OMZL::completion)
fpath=("$HOME/.zsh/completions" $fpath)
# OPENSPEC:END

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename "${ZDOTDIR:-$HOME}/.zshrc"

DISABLE_AUTO_TITLE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
DISABLE_MAGIC_FUNCTIONS="true"

export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export DOTNET_ROOT="$HOME/dotnet"
export PATH="$PATH:$HOME/dotnet"

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Редактор: vim по SSH, nvim локально (как в env)
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
export VISUAL="$EDITOR"

# История
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history
HISTDUP=erase

setopt APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE HIST_VERIFY HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY HIST_FIND_NO_DUPS HIST_EXPIRE_DUPS_FIRST
setopt AUTO_CD INTERACTIVE_COMMENTS EXTENDEDGLOB
setopt PUSHD_IGNORE_DUPS PUSHD_SILENT
unsetopt beep

# Показывать фактическое время для команд дольше N секунд (как `time`, но автоматически)
REPORTTIME=10

### Zinit
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Сниппеты Oh My Zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::key-bindings.zsh
zinit snippet OMZL::git.zsh
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZP::vi-mode

VI_MODE_SET_CURSOR=true

zinit wait lucid for \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting

zinit wait lucid atload"_zsh_autosuggest_start; bindkey '^F' autosuggest-accept" for \
    zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit snippet OMZP::git
zinit ice wait lucid
zinit snippet OMZP::github

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

ASYNCAPI_AC_ZSH_SETUP_PATH=~/.cache/@asyncapi/cli/autocomplete/zsh_setup
[[ -f $ASYNCAPI_AC_ZSH_SETUP_PATH ]] && source "$ASYNCAPI_AC_ZSH_SETUP_PATH"

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ -f "$HOME/.ghcup/env" ]] && source "$HOME/.ghcup/env"

alias pulm='java -jar ~/.local/plantuml/plantuml-1.2025.10.jar'

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Машиноспецифичное (не в git): переопределения, секреты, лишний PATH
[[ -f $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"

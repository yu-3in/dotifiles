export DOTFILES_PATH="$HOME/dotfiles"

########################################
# brew for M1 Mac
eval "$(/opt/homebrew/bin/brew shellenv)"

########################################
# install toolchains
source $DOTFILES_PATH/src/zshrc/install-toolchains.zsh

########################################
# plugins
zinit ice wait'!0'
zinit light "zsh-users/zsh-completions"

zinit ice wait'!0'
zinit light "zsh-users/zsh-syntax-highlighting"

zinit ice wait'!0'
zinit light SebastienWae/pnpm-completions

zinit ice wait'!0'
zinit light "felixr/docker-zsh-completion"

zinit ice wait'!0' atload"zpcdreplay" atclone'./zplug.zsh'
zinit light "g-plane/zsh-yarn-autocompletions"

autoload -Uz _zinit

########################################
# basics
export LANG=ja_JP.UTF-8

## use color
autoload -Uz colors
colors

## history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt share_history
setopt hist_ignore_all_dups

## word separator
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

## completion
autoload -Uz compinit && compinit -C
zstyle ':completion:*:default' menu select=2
### enable after sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
### completion in the middle name
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


## etc
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments

########################################
# key bindings
## skipping word when press Ctrl+ArrowKey
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
### for Mac
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

bindkey "^H" backward-kill-word

## substring search
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[OA" history-beginning-search-backward-end
bindkey "^[OB" history-beginning-search-forward-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

########################################
# alias
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias grep='grep --color'
alias tree='tree -sh'
alias beep='echo -en "\a"'

## enable alias after sudo
alias sudo='sudo '

########################################
# powerline-go
function powerline_precmd() {
  PS1="$(
    $POWERLINE_GO_DIR/$POWERLINE_GO_BIN \
      -shell zsh \
      -modules 'ssh,git,cwd' \
      -cwd-mode plain \
      -east-asian-width \
      -alternate-ssh-icon \
      -mode flat
  )"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi

########################################
# software settings

## sail
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

## go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

## rvenv
eval "$(rbenv init - zsh)"

## flutterfire_cli
export PATH="$PATH":"$HOME/.pub-cache/bin"

## flutter
export PATH="$PATH:/Users/yuuum/development/flutter/bin"

## volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

source /usr/local/etc/bash_completion.d/git-prompt.sh
precmd () { __git_ps1 "%{$fg_bold[cyan]%}%~%{$reset_color%} " "%# " "(%s) " }
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1

# Use vim as the editor
export EDITOR=vi

# history
export HISTFILE=~/.histfile
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

PATH=$PATH:~/bin:/usr/local/sbin

# By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# that those keys can be used for other things.
unsetopt flowcontrol

alias ez="vim ~/.zshrc"
alias sz="source ~/.zshrc"

alias ll="ls -alG"
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
alias g="git"
alias gs="git status"
alias gb="git branch -v"
alias gp="git pull"
alias gl="git log --oneline --graph --decorate --date=relative"
alias ber="bundle exec rake"

alias sr="screen -r"

function dc { dc-anywhere.sh $@ }

function mcd() { mkdir -p $1 && cd $1 } # from garybernhardt/dotfiles
function p() { cd $(find ~/projects -maxdepth 3 -type d | selecta) }

eval "$(rbenv init -)"
eval "$(direnv hook $0)"
eval "$(boot2docker shellinit)"
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export REDIS_URL='redis://192.168.59.103:6379'
export RABBITMQ_URL='amqp://192.168.59.103:5672'

alias lmix="~/projects/elixir/elixir/bin/mix"

zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

# antigen plugins:
source ~/.antigen/antigen.zsh

# antigen bundle olivierverdier/zsh-git-prompt
# antigen use oh-my-zsh
# antigen theme robbyrussell/oh-my-zsh themes/fino

antigen apply

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
alias cdf="cd ~/.dotfiles"

alias ll="ls -al"
alias gs="git status"
alias gb="git branch -v"
alias gp="git pull"
alias gl="git log --oneline --graph --decorate"
alias ber="bundle exec rake"

function dc { dc-anywhere.sh $@ }

function mcd() { mkdir -p $1 && cd $1 } # from garybernhardt/dotfiles

eval "$(rbenv init -)"
eval "$(direnv hook $0)"
eval "$(boot2docker shellinit)"

export REDIS_URL='redis://dockerhost:6379'
export RABBITMQ_URL='amqp://dockerhost:5672'

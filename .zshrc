zstyle :compinstall filename '/Users/jcarter/.zshrc'

autoload -Uz compinit
compinit

# antigen plugins:
source ~/antigen/antigen.zsh

antigen bundle olivierverdier/zsh-git-prompt

antigen apply

# Use vim as the editor
export EDITOR=vi

# history
export HISTFILE=~/.histfile
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

# add /usr/local/sbin to path
PATH=$PATH:/usr/local/sbin

# By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# that those keys can be used for other things.
unsetopt flowcontrol

alias ll="ls -al"
alias gs="git status"
alias gb="git branch -v"
alias ber="bundle exec rake"

PROMPT='%B%m%~%b$(git_super_status) %# '

eval "$(rbenv init -)"
eval "$(direnv hook $0)"

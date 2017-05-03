zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word

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
export TERM=screen-256color # for vim colors to work properly in tmux

PATH=$PATH:~/bin:/usr/local/sbin

# By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# that those keys can be used for other things.
unsetopt flowcontrol

alias ez="vim ~/.zshrc"
alias sz="source ~/.zshrc"

alias ll="ls -alG"
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
alias g="git"
alias gb="git branch"
alias gs="git status -s"
alias gl="git log --oneline --graph --decorate --date=relative"
alias b="bundle exec"

function dc { dc-anywhere.sh $@ }

function mcd() { mkdir -p $1 && cd $1 } # from garybernhardt/dotfiles
function cdf() { cd *$1*/ } # stolen from @topfunky
function p() { cd $(find ~/projects -maxdepth 3 -type d | selecta) }

# Use C-x C-e to edit the current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# that those keys can be used for other things.
unsetopt flowcontrol
# Run Selecta in the current working directory, appending the selected path, if
# any, to the current command.
function insert-selecta-path-in-command-line() {
  local selected_path
  # Print a newline or we'll clobber the old prompt.
  echo
  # Find the path; abort if the user doesn't select anything.
  selected_path=$(find * -type f | selecta) || return
  # Append the selection to the current command buffer.
  eval 'LBUFFER="$LBUFFER$selected_path"'
  # Redraw the prompt since Selecta has drawn several new lines of text.
  zle reset-prompt
}
# Create the zle widget
zle -N insert-selecta-path-in-command-line
# Bind the key to the newly created widget
bindkey "^S" "insert-selecta-path-in-command-line"

# eval "$(rbenv init -)"
source ~/.rvm/scripts/rvm
# source ~/.rvm/contrib/ps1_functions
# ps1_set
# PS1="\$(~/.rvm/bin/rvm-prompt) $PS1"
eval "$(direnv hook zsh)"
# eval "$(docker-machine env default)"

export GOPATH=$HOME/golang
function gp() { cd $(find $GOPATH/src -maxdepth 3 -type d | selecta) }
export PATH=$PATH:$GOPATH/bin
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home

alias br="bosh create release --force && bosh -n upload release"

export PATH=$PATH:/Users/jcarter/.cargo/bin
alias antlr="java -jar ~/golang/src/github.com/millergarym/antlr4-go/lib/antlr4-4.5.4-SNAPSHOT.jar"

cf_routes() {
  curl "http://router:router@10.244.0.22:8080/routes" | jq
}

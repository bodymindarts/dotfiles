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
alias b="bosh2"
alias bc="~/projects/starkandwayne/bucc/bin/bucc"

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

eval "$(direnv hook zsh)"

export PATH=${PATH}:~/projects/starkandwayne/bucc/bin/
alias br="bosh create release --force && bosh -n upload release"
alias tf=terraform

export PATH=$PATH:/Users/jcarter/.cargo/bin
export PATH=$PATH:/Users/jcarter/go/bin
alias antlr="java -jar ~/golang/src/github.com/millergarym/antlr4-go/lib/antlr4-4.5.4-SNAPSHOT.jar"

cf_routes() {
  curl "http://router:router@10.244.0.22:8080/routes" | jq
}

. /Users/jcarter/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
# export PATH="/usr/local/opt/erlang@19/bin:$PATH"
# export PATH="$HOME/.exenv/bin:$PATH"
# eval "$(exenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export LC_ALL=en_US.UTF-8

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jcarter/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jcarter/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jcarter/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jcarter/google-cloud-sdk/completion.zsh.inc'; fi

alias k=kubectl
alias ctags="`brew --prefix`/bin/ctags"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

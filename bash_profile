eval "$(rbenv init -)"

alias ll="ls -al"
alias gs="git status"
alias gb="git branch -v"
alias ber="bundle exec rake"

# to initialize direnv
eval "$(direnv hook bash)"

# git completion:
source ~/git-completion.bash

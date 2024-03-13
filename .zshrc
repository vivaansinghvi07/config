export CLICOLOR=1
export LSCOLORS=fxgxcxdxbxegedabagacad

# notes about this one: 
# %n %m is user and device respectively
# the %# symbol is for % instead of $ in cmd  
# ANSI codes need the dollar sign single quote for the quote 
# they also need to be in %{ ... %} brackets 
# %~ for relative path to home, %1 for one dir, %/ for absolute path
export PS1=$'%{\033[1;36m%}%n@%m%{\033[34m%} %~ %{\033[39m%}$%{\033[0m%} '

# commands i've written to this mac:
# message
# jupyterloc

# adding java to my path variable
export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
if [[ ! $PATH = *"JavaAppletPlugin"* ]] then
  export PATH=$JAVA_HOME/bin:$PATH
fi 

# aliases for personal use
alias ll="ls -al"
alias venv=". _venv"
alias rmvenv="deactivate; rm -rf .venv"
alias vim="nvim"
alias cfcd="cd ~/Documents/Code/GitHub/codeforces/"
alias ghcd="cd ~/Documents/Code/GitHub/"
alias cffind="ls -R | grep "
alias copy="pbcopy <"

# functions for personal use 
function selfclone() {
  repo=${${1##[[:space:]]##}%%[[:space:]]##}
  git clone git@github.com:vivaansinghvi07/$repo.git
}

function openapp() {
  osascript -e "tell application \"$1\" to activate"
}

function german() {
  open -a "Google Chrome" "https://dict.leo.org/german-english/$*"
}

function man() {
  export LESS_TERMCAP_md=$'\e[01;31m' 
  export LESS_TERMCAP_me=$'\e[0m' 
  export LESS_TERMCAP_us=$'\e[01;32m' 
  export LESS_TERMCAP_ue=$'\e[0m' 
  export LESS_TERMCAP_so=$'\e[45;93m' 
  export LESS_TERMCAP_se=$'\e[0m' 
  command man "$@"
}

eval $(thefuck --alias)
eval "$(zoxide init zsh)"

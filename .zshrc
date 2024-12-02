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
# grace
# jupyterloc
# venv

# adding java to my path variable
export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
if [[ ! $PATH = *"JavaAppletPlugin"* ]] then
  export PATH=$JAVA_HOME/bin:$PATH
fi 

# aliases for personal use
alias editrc="vim ~/.zshrc && source ~/.zshrc"
alias vim="nvim"
alias cfcd="cd ~/Documents/Code/GitHub/codeforces/"
alias ghcd="cd ~/Documents/Code/GitHub/"
alias cffind="ls -R | grep "
alias copy="pbcopy <"
alias rpass="cat ~/.remarkable_passkey | pbcopy"
alias rssh="ssh root@10.11.99.1"
alias ll='eza --long --sort=time --time=modified --time-style=relative --all --git --color=auto --icons=auto --group-directories-first --dereference'
alias gcc="clang"
alias g++="clang++"

# functions for personal use
function selfclone() {
  repo=${${1##[[:space:]]##}%%[[:space:]]##}
  git clone git@github.com:vivaansinghvi07/$repo.git
}

function ignore() {
  echo "*" > "$1/.gitignore"
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

function addpush() {
  msg=${@: -1}
  shift -p
  git add $@
  git commit -m $msg
  git push
}

eval $(thefuck --alias)
eval "$(zoxide init zsh --no-cmd)"

function find_venv() {
  setopt nullglob
  current_dir="$PWD"
  deactivate &>/dev/null
  while [[ "$current_dir" != "/" ]]; do
    if ls "$current_dir"/.* &>/dev/null; then
      for item in "$current_dir"/.*; do
        if [[ -d "$item" ]]; then
          if [[ -f "$item/bin/activate" ]]; then
            source $item/bin/activate
            echo "Switching to environment: $item"
            unsetopt nullglob
            return
          fi
        fi
      done
    fi
    current_dir="$(dirname "$current_dir")"
  done
  echo "No environments found."
  unsetopt nullglob
  return 1
}

function z() {
  __zoxide_z "$@"
  find_venv >/dev/null
}

function zi() {
  __zoxide_zi "$@"
}

function zz() {
  z "$@"
  find_venv
}

function py() {
  python3 -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'
  if [ $? -eq 1 ]; then
    uv pip install ipykernel
    py
  fi
}

function venv() {
  deactivate &>/dev/null
  find_venv > /dev/null
  if [ $? -eq 0 ]; then 
    return
  fi

  venv_name=".$(basename $PWD)-venv"

  if [ ! -d $venv_name ]; then
    python3.11 -m venv $venv_name
    echo "*" >> $venv_name/.gitignore
  fi
  source $venv_name/bin/activate
  if [ -f requirements.txt ]
  then
    uv pip install -r requirements.txt
  elif [ -f pyproject.toml ]; then
    uv pip install .
  fi
}

function ipyinit() {
  name="$(basename $PWD)-venv"
  python -m ipykernel install --user --name=$name --display-name="\"$name\""
}

function nb() {
  name="$(basename $PWD)-venv"
  venv
  uv pip install ipykernel
  ipyinit
  jupyter notebook
}

function github() {
  origin_host=$(git remote get-url origin)
  if [[ $origin_host = "https://"* ]]; then
    open $origin_host
  else
    open $(echo $origin_host | sed "s/git@\([a-zA-Z\.]*\):\([a-zA-Z0-9_\-]*\/[a-zA-Z0-9_\-]*\)\(\.git\)\{0,1\}\$/https:\/\/\1\/\2/") 
  fi
}


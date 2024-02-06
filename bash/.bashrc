# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi

# User specific environment and startup programs
HOST_NAME=mschindler

source ~/.nvm/nvm.sh
nvm use default

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" >/dev/null
eval "$(thefuck --alias)"

. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# shell config
export PATH=$PATH:$HOME/bin
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
bldgrn='\e[1;32m' # Bold Green
bldpur='\e[1;35m' # Bold Purple
txtrst='\e[0m'    # Text Reset

emojis=("🌐" "🧑‍💻")
EMOJI=${emojis[$RANDOM % ${#emojis[@]}]}

print_before_the_prompt() {
  dir=$PWD
  home=$HOME
  dir=${dir/"$HOME"/"~"}
  printf "\n $txtred%s: $bldpur%s $txtgrn%s\n$txtrst" "$HOST_NAME" "$dir" "$(vcprompt)"
}

PROMPT_COMMAND=print_before_the_prompt
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
PS1="$EMOJI >"

function mkcd() {
  mkdir $1 && cd $1
}

function stopd() {
  docker stop $(docker ps -aq -f name=$1)
}

# -------
# Aliases
# -------
alias c='code .'
alias ss='mix phx.server'
alias api='npm run --prefix assets generate-api'
alias ns='npm start'
alias nr='npm run'
alias run='npm run'
alias runp='npm --prefix assets run'
alias l="ls"      # List files in current directory
alias ll="ls -al" # List all files in current directory in long list format
alias ads='cd ~/Documents/dev/ad_schedule'
alias tests="script/tests"
alias merc='cd ~/Documents/dev/mercury/webapp'
alias dev='cd ~/Documents/dev'
alias plan='cd ~/Documents/dev/plan_item_form'
alias s='rm -rf tmp/pids && script/start'
alias ref='cd ~/Documents/dev/reference_data/'
alias stp='script/setup'
alias dclearimg="docker rmi $(docker images | grep '^<none>' | awk '{print $3}')"
alias gbl="git branch --sort=-committerdate"
alias vpnmerc="sudo openvpn ~/Documents/dev/mercury.conf"

# ----------------------
# Git Aliases
# ----------------------
alias gco='git checkout'
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gi='git init'
alias gl='git log'
alias gp='git pull'
alias gpsh='git push'
alias gss='git status -s'
alias gpushf='git push --force-with-lease'
alias gs='echo ""; echo "*********************************************"; echo -e "   DO NOT FORGET TO PULL BEFORE COMMITTING"; echo "*********************************************"; echo ""; git status'
alias gpub='git push --set-upstream origin new-branch'
alias gcia='git ci --amend'

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

git config --global user.name "Martin Schindler"
git config --global user.email "martin.schindler@getmercury.io"
git config --global core.editor "vim"

unset rc

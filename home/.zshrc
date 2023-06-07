export SSH_ASKPASS=/usr/bin/ssh-askpass

export ZSH=$HOME/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump common-aliases debian docker encode64 git-extras httpie history jira sbt scala ssh-agent sudo supervisor brews gradle colorize zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias g=git
alias gn=git np
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='nvim'
fi

ulimit -n 32000 2>&1 > /dev/null || true

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

if [[ -f $HOME/.keychain/`hostname`-sh ]]; then
    source $HOME/.keychain/`hostname`-sh
fi

source $HOME/.homesick/repos/homeshick/homeshick.sh


# Color input in red
function red {
  echo $(tput setaf 1)"$@"$(tput sgr0)
}

# Color input in yellow
function yellow {
  echo $(tput setaf 3)"$@"$(tput sgr0)
}

# Color input in green
function green {
  echo $(tput setaf 2)"$@"$(tput sgr0)
}

# Make the input bold
function bold {
  echo $(tput bold)"$@"$(tput sgr0)
}

# Log to standard error
function log {
  echo "$@" >2
}

# Add ERROR in red+bold
function error {
  echo $(red $(bold ERROR)) "$@"
}

# Add WARNING in yellow+bold
function warning {
  echo $(yellow $(bold WARN)) "$@"
}

# setup tracing (e.g. trace all commands on stderr
function setup_tracing() {
  BASH_XTRACEFD=2
  set -x
}

# encode a URN for http requests
function http_encode_urn() {
  sed -e "s/:/%3A/g"
}

# Base restli call
function restli() {
  curli --dv-auth SELF --logging-level ERROR --pretty-print  -H "X-RestLi-Protocol-Version: 2.0.0" -H "Accept: application/json" "$@"
}

function restli_get() {
  restli "$@"
}

# input from stdin
function restli_post() {
  restli -d @- -X POST "$@"
}

# input from stdin, patch wrapper already present
function restli_patch() {
  jq '{patch: .}' | restli_post -H "X-RestLi-Method: partial_update" "$@"
}

# input from stdin, patch wrapper already present
function restli_batch_patch() {
  jq '{patch .}' | restli_post -H "X-RestLi-Method: batch_partial_update" "$@"
}


prompt_context() {}


function checkout() {
  if [[ -d "$HOME/src/$1" ]]; then
    cd $HOME/src/$1
  else
    cd $HOME/src
    mint clone $1 --destination $1
    cd $1
  fi
}
alias vim=nvim
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

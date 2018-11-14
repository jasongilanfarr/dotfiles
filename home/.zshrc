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
plugins=(git autojump common-aliases debian docker encode64 git-extras httpie history jira sbt scala ssh-agent sudo supervisor brews gpg-agent gradle)

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

if [[ $(uname) -eq "Linux" ]]; then
    alias pbcopy="xclip -sel clip"
fi

alias findrbs=/home/jgilanfa/src/lms-productivity-analysis-tools/build/lms-productivity-analysis-tools/deployable/bin/find_rbs


export JAVA_HOME=/export/apps/jdk/JDK-1_8_0_121

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
  curli -H 'Authenticate: X-RestLI SUPERUSER:urn:li:system:0'  --dv-auth SELF --logging-level ERROR --pretty-print  -H "X-RestLi-Protocol-Version: 2.0.0" -H "Accept: application/json" "$@"
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

# request fast access to a single resource, don't use this, use request_fast_access
function request_single_fast_access() {
  local current_acls="$1"
  local resource="$2"
  local d2Endpoint="$3"

  if [[ "$current_acls" != *"$resource"* ]]; then
    acl-tool fast_dv_access create --actor $USER --resource-urn "urn:li:restli:$resource" 1>/dev/null 2>/dev/null
  fi

  local got_access="false"
  for i in {1..20}; do
    if [[ "$(restli_get -I -w "%{http_code}" -o /dev/null "d2://$resource/1")" == "403" ]]; then
      echo "Waiting for fast access to $resource to propagate, trying again in 30seconds"
      sleep 30
    else
      got_access="true"
      echo "$(green Fast access to $resource propagated.)"
      break
    fi
  done
  if [[ "$got_access" == "false" ]]; then
    warning "Fast access to $resource not verified"
  fi
}

# requests fast access to  a set of restli urns + d2 endpoints
# and verify fast access has propagated.
# uscp-backend/activityViews activityViewsBackend, tscp-admin-core/adCreativesV2 adCreativesV2"
function request_fast_access() {
  echo "Making a dummy request for datavault credentials"
  restli_get -I -o /dev/null d2://ugcPosts/1
  tput cuu1
  local current_acls=$(acl-tool fast_dv_access find --actor "$USER" 2>/dev/null | grep urn:li:restli | cut -f 2 -d '|' | tr -d '\n' | tr -d ' ')

  local commands=""
  IFS=',' read -a single_fa <<< "$@"
  for i in "${single_fa[@]}"; do
    commands="$commands request_single_fast_access $current_acls $i\n"
  done

  printf "$commands" | parallel --no-notice
}
export VOLTA_HOME="/Users/jgilanfa/.volta"
grep --silent "$VOLTA_HOME/bin" <<< $PATH || export PATH="$VOLTA_HOME/bin:$PATH"

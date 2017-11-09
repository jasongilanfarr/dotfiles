export SSH_ASKPASS=/usr/bin/ssh-askpass

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

source $HOME/.homesick/repos/homeshick/homeshick.sh

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

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='nvim'
fi

ulimit -n 32000 2>&1 > /dev/null || true

#!/usr/bin/env bash

curli_fabric="ei-ltx1"
curli_prefix="d2://"
curli_user="SUPERUSER:urn:li:system:0"

function curli_base {
  uri=$1
  shift
  curli --pretty-print -H "Authenticate: X-RestLI ${curli_user}" -H "X-RestLi-Protocol-Version: 2.0.0" \
    --fabric "${curli_fabric}" "${curli_prefix}${uri}" $* 2>/dev/null
}

# usage: curli_get restliEndpoint otherArgs
function curli_get {
  curli_base $*
}

# usage curli_post restliEndpoint otherArgs << input from STDIN
function curli_post {
  curli_base $* -X POST -d @-
}

# usage curli_patch restliEndpoint otherArgs << input from STDIN
function curli_patch {
  jq '{patch: {"$set": .}}' | curli_post $* -H 'X-RestLi-Method: partial_update'
}



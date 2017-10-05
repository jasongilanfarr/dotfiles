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

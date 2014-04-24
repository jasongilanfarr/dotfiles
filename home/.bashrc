source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

if [ -f /usr/local/bin/brew ]; then
if [ -f `brew --prefix`/etc/bash_completion ]; then
    source `brew --prefix`/etc/bash_completion
fi
fi

if [ -f /etc/bash_completions ]; then
    . /etc/bash_completions
fi

if [[ $TERM = xterm-* ]]; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      BASE03=$(tput setaf 234)
      BASE02=$(tput setaf 235)
      BASE01=$(tput setaf 240)
      BASE00=$(tput setaf 241)
      BASE0=$(tput setaf 244)
      BASE1=$(tput setaf 245)
      BASE2=$(tput setaf 254)
      BASE3=$(tput setaf 230)
      YELLOW=$(tput setaf 136)
      ORANGE=$(tput setaf 166)
      RED=$(tput setaf 160)
      MAGENTA=$(tput setaf 125)
      VIOLET=$(tput setaf 61)
      BLUE=$(tput setaf 33)
      CYAN=$(tput setaf 37)
      GREEN=$(tput setaf 64)
    else
      BASE03=$(tput setaf 8)
      BASE02=$(tput setaf 0)
      BASE01=$(tput setaf 10)
      BASE00=$(tput setaf 11)
      BASE0=$(tput setaf 12)
      BASE1=$(tput setaf 14)
      BASE2=$(tput setaf 7)
      BASE3=$(tput setaf 15)
      YELLOW=$(tput setaf 3)
      ORANGE=$(tput setaf 9)
      RED=$(tput setaf 1)
      MAGENTA=$(tput setaf 5)
      VIOLET=$(tput setaf 13)
      BLUE=$(tput setaf 4)
      CYAN=$(tput setaf 6)
      GREEN=$(tput setaf 2)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    # Linux console colors. I don't have the energy
    # to figure out the Solarized values
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

export PATH=/opt/cmake/bin:/opt/llvm/bin:/usr/local/bin:$PATH
export PROD="--gateway=https://production.upthere.com"
export STAGING="--gateway=https://staging.upthere.com"
export PS1="\[${BOLD}${GREEN}\]\u\[$YELLOW\]@\[$BLUE\]\h:\[$ORANGE\]\w\[$RED\]\$(__git_ps1)\[$YELLOW\] \$ \[$RESET\]"

homeshick --quiet refresh

if [ -f /usr/local/bin/gdircolors ]; then
    eval `gdircolors ~/.dircolors`
else
    eval `dircolors ~/.dircolors`
fi

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWCOLORHINTS=1

export ANDROID_STANDALONE_NDK=/usr/local/android-ndk-r9-clang
export ANDROID_SDK=/usr/local/Cellar/android-sdk/22.3
export ANDROID_HOME=$ANDROID_SDK
export PATH=$PATH:/usr/local/android-ndk-r9b:/usr/local/facebook/arcanist/bin
export EDITOR="mvim -f"

if [ -f /usr/local/bin/gls ]; then
    alias ls='gls --color=auto'
else
    alias ls='ls --color'
fi

function repeat-gmalloc {
    x=0
    counter=1
    while [ $x -eq 0 ]; do
        echo "**** Starting $counter ****"
        MallocGuardEdges=1 MallocScribble=1 MALLOC_PERMIT_INSANE_REQUESTS=1 DYLD_INSERT_LIBRARIES=/usr/lib/libgmalloc.dylib $@
        x=$?
        echo "**** Completed $counter *****"
        counter=$(( $counter + 1 ))
    done
}

function repeat {
    x=0
    counter=1
    while [ $x -eq 0 ]; do
        echo "**** Starting $counter ****"
        MallocGuardEdges=1 MallocScribble=1 $@
        x=$?
        echo "**** Completed $counter *****"
        counter=$(( $counter + 1 ))
    done
}

function tabc {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
  osascript -e "tell application \"Terminal\" to set current settings of front window to settings set \"$NAME\""
}

function ssh {
  tabc "IR_Black"
  /usr/bin/ssh "$@"
  tabc "Solarized Dark"
}

function startvm {
    "/Applications/VMware Fusion.app/Contents/Library/vmrun" -T fusion start  ~/Documents/Virtual\ Machines.localized/Ubuntu\ 64-bit.vmwarevm/ nogui
}

function stopvm {
    "/Applications/VMware Fusion.app/Contents/Library/vmrun" -T fusion suspend  ~/Documents/Virtual\ Machines.localized/Ubuntu\ 64-bit.vmwarevm/ nogui
}

function linuxvm {
    startvm
    ssh -A 192.168.111.128
}



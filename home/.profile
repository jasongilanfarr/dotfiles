

export PATH="$HOME/.cargo/bin:$PATH"
export VOLTA_HOME="/Users/jgilanfa/.volta"
grep --silent "$VOLTA_HOME/bin" <<< $PATH || export PATH="$VOLTA_HOME/bin:$PATH"

alias ls='ls -GF'

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}

alias hpaste="history|cut -d ' ' -f 5-"

export PATH="/usr/local/bin:$PATH"
pathadd $(pyenv root)/shims
pathadd $HOME/bin

pathadd $HOME/org/bin
for file in $HOME/org/*; do
    source $file
done

fortune

alias cvlc="/Applications/VLC.app/Contents/MacOS/VLC"

export EDITOR="nvim"


function t() {
    tmux new-session -s "$(basename $(pwd))"
}

# make sure homebrew takes precedence
eval "$(/opt/homebrew/bin/brew shellenv)"

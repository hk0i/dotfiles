alias ls='ls -GF'

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}

alias hpaste="history|cut -d ' ' -f 5-"

pathadd $(pyenv root)/shims
export PATH="/usr/local/bin:$PATH"
pathadd $HOME/bin

pathadd $HOME/org/bin
for file in $HOME/org/*; do
    source $file
done

fortune

alias cvlc="/Applications/VLC.app/Contents/MacOS/VLC"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export EDITOR="nvim"


function t() {
    tmux new-session -s "$(basename $(pwd))"
}

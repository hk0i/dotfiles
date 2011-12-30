alias ls='ls -G'
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$PATH:$1"
    fi
}

function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

TITLEBAR="\u@\h \w"
TITLEBAR="\e]2;$TITLEBAR\a"
export PS1="\[$TITLEBAR\]\[\e[33m\]\W\[\e[37m\]/\$(parse_git_branch) \[\e[32;1m\]\$ \[\e[0m\]"
alias hpaste="history|cut -d ' ' -f 5-"

fortune

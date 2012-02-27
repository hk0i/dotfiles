alias ls='ls -G'
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

complete -C $HOME/bin/rake-completion.rb -o default rake

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}

function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

TITLEBAR="\u@\h \w"
TITLEBAR="\e]2;$TITLEBAR\a"
export PS1="\[$TITLEBAR\]\[\e[33m\]\W\[\e[37m\]/\$(parse_git_branch) \[\e[32;1m\]\$ \[\e[0m\]"
alias hpaste="history|cut -d ' ' -f 5-"

pathadd $HOME/bin
pathadd /Applications/MAMP/bin
pathadd /Applications/MAMP/Library/bin
pathadd /Applications/MAMP/bin/php/php5.2.17/bin

#add mysql dylib to dylib path
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib/"

#mysql aliases for native install -- no longer using native install
# alias mysql=/usr/local/mysql/bin/mysql
# alias mysqladmin=/usr/local/mysql/bin/mysqladmin
# alias mysql="/Applications/MAMP/Library/bin/mysql"
# alias mysqladmin="/Applications/MAMP/Library/bin/mysqladmin"
# alias apachectl="/Applications/MAMP/bin/apache2/bin/apachectl"

fortune
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

alias zf="$HOME/Sites/ZendFramework-1.10.6/bin/zf.sh"

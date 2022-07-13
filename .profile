alias ls='ls -GF'

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}

alias hpaste="history|cut -d ' ' -f 5-"

export PATH="/usr/local/bin:$PATH"
pathadd $HOME/bin
pathadd /Applications/MAMP/bin
pathadd /Applications/MAMP/Library/bin
pathadd /Applications/MAMP/bin/php/php5.2.17/bin
pathadd $(pyenv root)/shims

#add mysql dylib to dylib path
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib/"

#mysql aliases for native install -- no longer using native install
# alias mysql=/usr/local/mysql/bin/mysql
# alias mysqladmin=/usr/local/mysql/bin/mysqladmin
# alias mysql="/Applications/MAMP/Library/bin/mysql"
# alias mysqladmin="/Applications/MAMP/Library/bin/mysqladmin"
# alias apachectl="/Applications/MAMP/bin/apache2/bin/apachectl"

fortune

alias zf="$HOME/Sites/ZendFramework-1.10.6/bin/zf.sh"
alias cvlc="/Applications/VLC.app/Contents/MacOS/VLC"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export EDITOR="nvim"

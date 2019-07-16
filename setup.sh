#!/bin/bash

abspath=$(cd ${0%/*} && echo $PWD/${0##*/})
abspath=$(dirname ${abspath})

function createLink() {
    fileOrDir="$1"
    if [[ -f ${HOME}/$1 ]]; then
        mv ${HOME}/$1 ${HOME}/$1-original
        echo "[setup] ${HOME}/$1 detected! Moving to ${HOME}/$1-original"
    fi

    if [[ -L ${HOME}/$1 ]]; then
        echo "[setup] ${HOME}/$1: symlink detected. Do nothing."
        return
    fi

    ln -sf ${abspath}/$1 ${HOME}/$1
}


for file in $(ls -a ${abspath})
do
    if [[ $file != '.' && $file != '..' && $file != 'README.md' && $file != 'setup.sh' && $file != '.git' ]]; then
        createLink $file
    fi
done

mkdir -p ~/.vim/bak
. ~/.profile

# install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +BundleInstall +qall

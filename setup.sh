#!/bin/bash

abspath=$(cd ${0%/*} && echo $PWD/${0##*/})
abspath=$(dirname ${abspath})

function createLink() {
    fileOrDir="$1"
    if [[ -f ${HOME}/$1 ]]; then
        mv ${HOME}/$1 ${HOME}/$1-original
        echo "[setup] ${HOME}/$1 detected! Moving to ${HOME}/$1-original"
        return
    fi

    if [[ -L ${HOME}/$1 ]]; then
        echo "[setup] ${HOME}/$1: symlink detected. Do nothing."
        return
    fi

    ln -s ${abspath}/$1 ${HOME}/$1
}


for file in $(ls -a ${abspath})
do
    if [[ $file != '.' && $file != '..' && $file != 'README.md' && $file != 'setup.sh' && $file != '.git' ]]; then
        createLink $file
    fi
done

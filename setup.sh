#!/bin/bash

abspath=$(cd ${0%/*} && echo $PWD/${0##*/})
abspath=$(dirname ${abspath})

warning="⚠️  "
checkmark="✅ "
info="ℹ️  "
gear="⚙️ "

function createLink() {
    fileOrDir="$1"
    if [[ -f ${HOME}/$1 ]]; then
        mv ${HOME}/$1 ${HOME}/$1-original
        echo "$warning ${HOME}/$1 detected! Moving to ${HOME}/$1-original"
    fi

    if [[ -L ${HOME}/$1 ]]; then
        echo "$warning ${HOME}/$1: symlink detected. Do nothing."
        return
    fi

    (set -x; ln -sf ${abspath}/$1 ${HOME}/$1)
}

function linkAllDotFiles() {
    # do not copy files in exclude.list
    for file in $(ls -A ${abspath} | grep -vf exclude.list); do
        createLink $file
    done
}

function installOhMyZsh() {
    if [ -d ~/.oh-my-zsh ]; then
        echo "$checkmark oh-my-zsh detected; skipping setup."
        return
    fi

    echo "$gear Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function installVundle() {
    vundlePath=~/.vim/vundle/Vundle.vim
    if [ -d $vundlePath ]; then
        echo "$checkmark Vundle detected; skipping."
        return
    fi

    echo "$gear Installing Vundle (vim)..."
    git clone https://github.com/VundleVim/Vundle.vim.git $vundlePath
    vim +BundleInstall +qall
}

function initVim() {
	# TODO: install vim through homebrew for python3 support
    mkdir -p ~/.vim/bak
}

function installNvim() {
    which nvim > /dev/null
    if [ $? -eq 0 ]; then
        echo "$checkmark NeoVim detected; skipping."
        return
    fi

    echo "$gear Installing NeoVim..."
    brew install nvim python3
    pip3 install neovim
    linkNvimConfig
}

function linkNvimConfig() {
    mkdir -p "$HOME/.config" && ln -sf "${abspath}/nvim" "$HOME/.config/."
}

function installFortune() {
    which fortune > /dev/null
    if [ $? -eq 0 ]; then
        echo "$checkmark Fortune detected; skipping."
        return
    fi

    echo "$gear Installing fortune..."
    brew install fortune
}

function installMisc() {
    # installs misc brew packages
    brew install fzf
}

function installFonts() {
    # https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
    # TODO: download, extract and move to ~/Library/Fonts or /Library/Fonts
    # make sure to filter out any *Windows* compatible files and use otf where
    # available
    # also check if they're already installed first...
    echo "$gear installing nerdfonts"
}


initVim
linkAllDotFiles
installVundle
installNvim
installFortune
installMisc

. ~/.profile
installOhMyZsh

#!/bin/bash

# TODO:
#   Add node + nvm
#   Intel-One font
#   Split nvim installation and config linking steps
#   install ripgrep

abspath=$(cd ${0%/*} && echo $PWD/${0##*/})
abspath=$(dirname ${abspath})

source symbols.sh

function main() {
    installHomebrew

    disableDiacriticsMenu
    initVim
    linkAllDotFiles

    installRipGrep
    installVundle
    installNvim
    installFortune
    installMisc
    installPython
    installFonts
    installLazygit

    . ~/.profile
    installOhMyZsh
}

function installHomebrew() {
    echo "$info Checking for homebrew..."
    brew -v > /dev/null
    if [ $? == 0 ]; then
        echo "$checkmark homebrew detected; no action taken"
        return
    fi

    echo "$gear installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function disableDiacriticsMenu() {
    # disables the accent menu that shows up when holding certain letters down on the keyboard
    echo "$info Disabling MacOS Diacritics (press-and-hold)"
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
}

function installRipGrep() {
    which rg > /dev/null
    if [ $? -eq 0 ]; then
        echo "$checkmark ripgrep detected; skipping."
        return
    fi

    brew install ripgrep
}


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
    installVimPlug
    linkNvimConfig
    nvim +PlugInstall +qall
}

function installVimPlug() {
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
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
    echo "$info checking for fonts..."
    installIntelOneMono
    echo "$gear installing nerdfonts"

}

function installIntelOneMono() {
    echo "$info checking user fonts for IntelOneMono..."
    ls ~/Library/Fonts/IntelOneMono* > /dev/null
    if [ $? == 0 ]; then
        echo "$check ...IntelOneMono detected; skipping"
        return
    fi

    echo "$info checking system fonts for IntelOneMono..."
    ls /Library/Fonts/IntelOneMono* > /dev/null
    if [ $? == 0 ]; then
        echo "$check ...IntelOneMono detected; skipping"
        return
    fi

    startDirectory="$(pwd)"

        mkdir -p $HOME/src
        cd $HOME/src
        git clone https://github.com/intel/intel-one-mono.git
        installFonts "intel-one-mono/fonts/ttf/*.ttf"

    cd "$startDirectory"
}

function installFonts() {
    # installs the fonts, given their filenames
    open -b com.apple.FontBook "$1"
}

function installPyenv() {
    echo "$info checking for pyenv..."
    pyenv -h > /dev/null
    if [ $? == 0 ]; then
        echo "$check pyenv detected; skipping"
        return
    fi

    brew install pyenv
}

function installPython() {
    installPyenv

    echo "$info checking for python2..."

    python2 -h > /dev/null
    if [ $? == 0 ]; then
        echo "$check python detected; skipping"
        return
    fi

    pyenv install 2.7.18
    pyenv global 2.7.18

    echo "$check python2 installed"
}

function installLazygit() {
    echo "$info checking for lazygit..."

    which lazygit > /dev/null
    if [ $? == 0 ]; then
        echo "$check lazygit detected; skipping"
        return
    fi

    brew install lazygit

    echo "$check lazygit installed"
}

main

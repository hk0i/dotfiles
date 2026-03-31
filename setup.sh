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
    linkGhosttyConfig

    installRvm
    installRipGrep
    installVundle
    installNvim
    installFortune
    installMisc
    installPython
    installDevFonts
    installLazygit
    installBrewApps
    installXcodes

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

function linkGhosttyConfig() {
    # TODO: consolidate with linkNvimConfig above
    mkdir -p "$HOME/.config" && ln -sf "${abspath}/ghostty" "$HOME/.config/."
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

function installDevFonts() {
    ./setup/installFonts.sh
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

function installGpg() {
    echo "$info checking for gpg..."
    which gpg > /dev/null
    if [ $? -eq 0 ]; then
        echo "$info checking for gpg..."
        return
    fi

    brew install gnupg
}

function installRvm() {
    installGpg

    echo "$info checking for rvm..."
    if ! command -v rvm &> /dev/null; then
        echo "$info rvm not found. Installing..."
        curl -sSL https://rvm.io/mpapis.asc | gpg --import -
        curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -

        # Only install the RVM manager first
        \curl -sSL https://get.rvm.io | bash -s -- --latest
    fi

    # CRITICAL: Source it here so the 'rvm' command works for the ruby check below
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

    echo "$info checking for ruby..."
    if ! rvm list strings | grep -q "ruby-"; then
        echo "$info ruby not found. Installing latest..."

        # 1. Install what's actually available
        brew install openssl@3 libyaml gmp readline

        # 2. Tell RVM NOT to try installing missing brew packages
        rvm autolibs read-only

        # update rvm to get latest rubies
        rvm get head
        rvm install ruby --latest
        rvm use ruby --latest --default
    else
        echo "$info checking for ruby..."
    fi
}

function installBrewApps() {
    local list_file="${abspath}/brew-apps.list"
    local app_dir="/Applications"

    while IFS= read -r app || [[ -n "$app" ]]; do
        [[ -z "$app" || "$app" =~ ^# ]] && continue

        echo "$info checking for $app..."

        # 1. Skip if already managed by brew
        if brew list "$app" &>/dev/null; then
            echo "$checkmark $app detected; skipping."
            continue
        fi

        # 2. Check if the package is specifically a Cask
        # 'brew info --cask' returns 0 if a cask with that name exists
        if brew info --cask "$app" &>/dev/null; then
            echo "$gear $app identified as a GUI app. Installing cask..."

            # Clean up manual install if it exists
            local manual_app=$(find "$app_dir" -maxdepth 1 -iname "${app}*.app" -print -quit)
            [[ -n "$manual_app" ]] && sudo rm -rf "$manual_app"

            brew install --cask "$app"
        else
            # 3. Otherwise, install as a standard formula
            echo "$gear installing $app formula..."
            brew install "$app"
        fi

        echo "$checkmark $app setup complete."
    done < "$list_file"
}

function installXcodes() {
    local app_path="/Applications/Xcodes.app"
    local cli_symlink="$HOME/bin/xcodes"

    echo "$info Checking for Xcodes..."
    if [[ ! -d "$app_path" ]]; then
        echo "$gear Installing Xcodes.app (Cask) for high-speed aria2 downloads..."
        brew install --cask xcodes
    fi

    # Link the bundled CLI so you can use 'xcodes' in the terminal
    if [[ ! -L "$cli_symlink" ]]; then
        echo "$info Linking bundled xcodes CLI to $cli_symlink..."
        ln -sf "$app_path/Contents/Resources/xcodes" "$cli_symlink"
    fi

    # Now use the CLI to get the latest Xcode
    if ! xcodes installed | grep -q "Selected"; then
        echo "$gear Downloading latest Xcode via aria2 (this will be fast)..."
        # The CLI will now use the bundled aria2 automatically
        xcodes install --latest --select
        sudo xcodebuild -license accept
    else
        echo "$checkmark Latest Xcode is already installed and selected."
    fi
}

main

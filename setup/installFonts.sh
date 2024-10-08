#!/bin/bash

function main() {
    echo "$info checking for fonts..."
    installIntelOneMono
    installFiraCode
}

function installIntelOneMono() {
    echo "$info checking user fonts for IntelOneMono..."
    ls ~/Library/Fonts/IntelOneMono* &> /dev/null
    if [ $? == 0 ]; then
        echo "$check ...IntelOneMono detected; skipping"
        return
    fi

    echo "$info checking system fonts for IntelOneMono..."
    ls /Library/Fonts/IntelOneMono* &> /dev/null
    if [ $? == 0 ]; then
        echo "$check ...IntelOneMono detected; skipping"
        return
    fi

    startDirectory="$(pwd)"

        mkdir -p $HOME/src
        cd $HOME/src
        if [ ! -d $HOME/src/intel-one-mono ]; then
            git clone https://github.com/intel/intel-one-mono.git
        fi
        installFonts intel-one-mono/fonts/ttf/*.ttf

    cd "$startDirectory"
}

function installFonts() {
    # installs the fonts, given their filenames
    open -b com.apple.FontBook "$1"
}

function installFiraCode() {
    echo "$gear installing nerdfonts"
    echo "$info checking for FiraCode..."
    ls ~/Library/Fonts/Fira\ Code* &> /dev/null
    if [ $? == 0 ]; then
        echo "$check ...FiraCode detected; skipping"
        return
    fi

    startDirectory="$(pwd)"

        tempDirectory="$(mktemp -d)"
        echo "$info temp: $tempDirectory"
        cd "$tempDirectory" && \
            curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip -o $tempDirectory/firacode.zip && \
            echo "$info downloaded to $tempDirectory" && \
            unzip $tempDirectory/FiraCode.zip && \
            installFonts "$tempDirectory/Fira Code Retina Nerd Font Complete.ttf"

    cd "$startDirectory"
}

main
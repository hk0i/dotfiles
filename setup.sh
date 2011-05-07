#!/bin/bash

abspath=$(cd ${0%/*} && echo $PWD/${0##*/})
abspath=$(dirname ${abspath})

function createBin() {
    homebin="${HOME}/bin"
    if [[ -d "${homebin}" || -L "${homebin}" ]]; then
        echo "[bin] Failed to create symbolic link ${homebin}. (Target exists)"
    else
        ln -s ${abspath}/bin "${homebin}"
        echo "[bin] ${homebin} -> ${abspath}/bin created."
    fi
}

createBin

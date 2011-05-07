#!/bin/bash

function createBin() {
    HOMEBIN="${HOME}/bin"
    if [[ -d "${HOMEBIN}" || -L "${HOMEBIN}" ]]; then
        echo "[bin] Failed to create symbolic link ${HOMEBIN}. (Target exists)"
    else
        ln -s bin/ "${HOMEBIN}"
        echo "[bin] ${HOMEBIN} created."
    fi
}

createBin

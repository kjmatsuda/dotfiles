#!/bin/bash

BACKUPDIR="${HOME}/backup/dotfiles/$(date +"%Y%m%d%H%M%S")"

if [ ! -d "${BACKUPDIR}" ]; then
    echo "mkdir -p ${BACKUPDIR}"
    mkdir -p ${BACKUPDIR}
fi

for file in .bashrc .emacs.min.el .globalrc .tmux.conf .config/fish/config.fish
do
    HOMEDOTFILE="${HOME}/${file}"
    CURRENTDOTFILE="$(pwd)/${file}"
    if [[ $(dirname ${file}) == */* ]]; then
        echo "mkdir -p ${BACKUPDIR}/$(dirname ${file})"
        mkdir -p ${BACKUPDIR}/$(dirname ${file})
    fi

    if [ -e "${HOMEDOTFILE}" ]; then
        cp -p ${HOMEDOTFILE} ${BACKUPDIR}/${file}
    fi

    if [ -e "${BACKUPDIR}/${file}" ] || [ ! -e "${HOMEDOTFILE}" ]; then
        echo "ln -sf ${CURRENTDOTFILE} ${HOMEDOTFILE}"
        ln -sf ${CURRENTDOTFILE} ${HOMEDOTFILE}
    fi
done

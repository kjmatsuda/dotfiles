#!/bin/bash

BACKUPDIR="${HOME}/backup/dotfiles/$(date +"%Y%m%d%I%M%S")"

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
    cp -p ${HOMEDOTFILE} ${BACKUPDIR}/${file}

    if [ -e "${BACKUPDIR}/${file}" ]; then
        # バックアップが作成できたら、シンボリックリンク作成
        echo "${BACKUPDIR}/${file} exists"
        ln -sf ${CURRENTDOTFILE} ${HOMEDOTFILE}
    fi
done

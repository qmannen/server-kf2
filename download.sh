#!/bin/bash

sudo su -c "${CONTAINER_DIR_STEAMCMD}/steamcmd.sh +force_install_dir ${CONTAINER_DIR_APP} +login anonymous +app_update ${STEAMCMD_APP_ID} validate +quit" ${CONTAINER_USER}
sudo chown ${CONTAINER_USER}:${CONTAINER_USER} -R ${CONTAINER_DIR_APP}

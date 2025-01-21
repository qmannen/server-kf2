#!/bin/bash

sudo su -c "/home/services/steamcmd/steamcmd.sh +force_install_dir ${CONTAINER_DIR_SERVICE} +login anonymous +app_update 232130 validate +quit" ${CONTAINER_USER}
sudo chown ${CONTAINER_USER}:${CONTAINER_USER} -R ${CONTAINER_DIR_SERVICE}

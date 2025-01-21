#!/bin/bash

cd ${CONTAINER_DIR_APP}

BINARY_FILE="$CONTAINER_DIR_APP/Binaries/Win64/KFGameSteamServer.bin.x86_64"
SERVER_CONFIG_FILE="$CONTAINER_DIR_APP/KFGame/Config/LinuxServer-KFGame.ini"
WEB_CONFIG_FILE="$CONTAINER_DIR_APP/KFGame/Config/KFWeb.ini"

echo "Preparing the server"
# First start to generate the config files
timeout 10 ${BINARY_FILE}
echo "Server prepared"

# LinuxServer-KFGame.ini
if [ -f "$SERVER_CONFIG_FILE" ]; then
	echo "Applying server configuration"
	sed -i "s/ServerName.*/ServerName=${KF2_GAME_NAME}/" ${SERVER_CONFIG_FILE}
	sed -i "s/MaxPlayers.*/MaxPlayers=${KF2_GAME_PLAYER_COUNT}/" ${SERVER_CONFIG_FILE}
	sed -i "s/AdminPassword.*/AdminPassword=${KF2_ADMIN_PASSWORD}/" ${SERVER_CONFIG_FILE}
fi

# KFWeb.ini
if [ -f "$WEB_CONFIG_FILE" ]; then
	# En- or disable webadmin
	echo "Applying web configuration"
	sed -i "s/bEnabled.*/bEnabled=${KF2_ADMIN_PASSWORD}/" ${WEB_CONFIG_FILE}
fi

echo "Starting the game"
${BINARY_FILE}
echo "Server has stopped"

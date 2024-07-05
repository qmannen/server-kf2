#!/bin/bash

cd /home/kf2

echo "Preparing the server"

# First start to generate the config files
(timeout 10 Binaries/Win64/KFGameSteamServer.bin.x86_64 > /dev/null 2>&1) || echo "Server Prepared"

# Copy the config
SERVER_CONFIG_FILE=/home/kf2/KFGame/Config/LinuxServer-KFGame.ini
WEB_CONFIG_FILE=/home/kf2/KFGame/Config/KFWeb.ini

if ! [ -f ${SERVER_CONFIG_FILE} ]; then

	if [ -f /tmp/kf2server.ini ]; then
	  echo "Applying server configuration"
	  cp /tmp/kf2server.ini ${SERVER_CONFIG_FILE}
	fi
fi

if ! [ -f ${WEB_CONFIG_FILE} ]; then
	# En- or disable webadmin
	echo "Applying web configuration"
	sed -i "s/bEnabled.*/bEnabled=${ENABLE_WEBADMIN}/" ${WEB_CONFIG_FILE}
fi

# Start the server
GAMECMD="KFGameContent.KFGameInfo_Survival"

if [ "${GAMEMODE}" = "Versus" ]; then
    GAMECMD="Game=KFGameContent.KFGameInfo_VersusSurvival&"
fi

if [ "${GAMEMODE}" = "Weekly" ]; then
    GAMECMD="Game=KFGameContent.KFGameInfo_WeeklySurvival&"
fi

if [ "${GAMEMODE}" = "Endless" ]; then
    GAMECMD="Game=KFGameContent.KFGameInfo_Endless&"
fi

echo "Starting the game"	
Binaries/Win64/KFGameSteamServer.bin.x86_64 ${START_MAP}?${GAMECMD}AdminName=${ADMIN}&AdminPassword=${ADMIN_PASSWORD}&MaxPlayers=${MAX_PLAYERS}&Difficulty=${DIFFICULTY}
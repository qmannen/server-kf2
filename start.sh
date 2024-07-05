#!/bin/bash

cd /home/kf2

echo "Preparing the server"

# First start to generate the config files
(timeout 10 Binaries/Win64/KFGameSteamServer.bin.x86_64 > /dev/null 2>&1) || echo "Server Prepared"

# Copy the config
SERVER_CONFIG_FILE=/home/kf2/KFGame/Config/LinuxServer-KFGame.ini
WEB_CONFIG_FILE=/home/kf2/KFGame/Config/KFWeb.ini

if [ -f "${SERVER_CONFIG_FILE}" ]; then
	echo "Applying server configuration"
	sed -i "s/AdminPassword.*/AdminPassword=${ADMIN_PASSWORD}/" ${SERVER_CONFIG_FILE}
fi

if [ -f ${WEB_CONFIG_FILE} ]; then
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

echo "Starting the game with map ${START_MAP} and command ${GAMECMD}AdminName=${ADMIN}&MaxPlayers=${MAX_PLAYERS}&Difficulty=${DIFFICULTY}"	
Binaries/Win64/KFGameSteamServer.bin.x86_64 ${START_MAP}?${GAMECMD}AdminName=${ADMIN}&MaxPlayers=${MAX_PLAYERS}&Difficulty=${DIFFICULTY}
echo "Server has stopped"
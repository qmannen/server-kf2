#!/bin/bash

# Copy the config
SERVER_CONFIG_FILE=/home/kf2/KFGame/Config/LinuxServer-KFGame.ini

if ! [ -f ${SERVER_CONFIG_FILE} ]; then

	if [ -f /tmp/kf2server.ini ]; then
	  echo "Applying server configuration"
	  cp /tmp/kf2server.ini ${SERVER_CONFIG_FILE}
	fi
fi

# Start the server
GAMECMD=""

if [ "${GAMEMODE}" = "Versus" ]; then
    GAMECMD="Game=KFGameContent.KFGameInfo_VersusSurvival&"
fi

if [ "${GAMEMODE}" = "Weekly" ]; then
    GAMECMD="Game=KFGameContent.KFGameInfo_WeeklySurvival&"
fi

if [ "${GAMEMODE}" = "Endless" ]; then
    GAMECMD="Game=KFGameContent.KFGameInfo_Endless&"
fi

cd /home/kf2

/home/kf2/Binaries/Win64/KFGameSteamServer.bin.x86_64 ${START_MAP}?${GAMECMD}AdminName=${ADMIN}&AdminPassword=${ADMIN_PASSWORD}&MaxPlayers=${MAX_PLAYERS}&Difficulty=${DIFFICULTY}
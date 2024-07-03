#!/bin/bash

# Copy the config
SERVER_CONFIG_FILE=/home/kf2/steamapps/232130/KFGame/Config/PCServer-KFGame.ini

if ! [ -f ${SERVER_CONFIG_FILE} ]; then

	if [ -f /tmp/KFGame.ini ]; then
	  echo "Applying server configuration"
	  cp /tmp/KFGame.ini ${SERVER_CONFIG_FILE}
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

/home/kf2/steamapps/232130/Binaries/Win64/KFGameSteamServer.bin.x86_64 ${START_MAP}?${GAMECMD}AdminName=${ADMIN}&AdminPassword=${ADMIN_PASSWORD}&MaxPlayers=${MAX_PLAYERS}&Difficulty=${DIFFICULTY}
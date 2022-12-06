#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true

# Override SteamCMD launch arguments if necessary
# Used for subscribing to betas or for testing
if [ -z "${STEAMCMD_UPDATE_ARGS}" ]; then
	bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" +login anonymous +app_update "${STEAMAPPID}" +quit
else
	steamcmd_update_args=($STEAMCMD_UPDATE_ARGS)
	bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" +login anonymous +app_update "${STEAMAPPID}" "${steamcmd_update_args[@]}" +quit
fi

# Replace pre-set variables
sed -i -e 's/server_port 20100/'"server_port ${SERVER_PORT}"'/g' \
		-e 's/server_region europe/'"server_region ${SERVER_REGION}"'/g' \
		-e 's/steam_query_port 27000/'"steam_query_port ${STEAM_QUERY_PORT}"'/g' \
			"${STEAMAPPDIR}/${SERVER_CONFIG_PATH}"

cd "${STEAMAPPDIR}"

"./Holdfast NaW" -startserver \
				-batchmode \
				-nographics \
				-screen-width "${SCREEN_WIDTH}" \
				-screen-height "${SCREEN_HEIGHT}" \
				-screen-quality "${SCREEN_QUALITY}" \
				-framerate "${FPSMAX}" \
				--serverheadless \
				-serverConfigFilePath "${SERVER_CONFIG_PATH}" \
				-logFile "${SERVER_LOG_PATH}" \
				-logArchivesDirectory "${SERVER_LOG_ARCHIVE_PATH}" \
				-p "${SERVER_PORT}" \
				{{ADDITIONAL_ARGS}}

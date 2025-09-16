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
  		-e 's/server_admin_password defaultAdminPWReplace/'"server_admin_password ${SERVER_ADMIN_PASSWORD}"'/g' \
	  	-e 's/server_name My Server/'"server_name ${SERVER_NAME}"'/g' \
	  	-e 's/server_welcome_message The Server Welcome Message/'"server_welcome_message ${SERVER_WELCOME_MESSAGE}"'/g' \
	  	-e 's/server_intro_title Welcome!/'"server_intro_title ${SERVER_INTRO_TITLE}"'/g' \
	  	-e 's/server_intro_body This is a server fresh of the assembly line/'"server_intro_body ${SERVER_INTRO_BODY}"'/g' \
	  	-e 's/network_broadcast_mode Standard/'"network_broadcast_mode ${SERVER_NETWORK_BROADCAST_MODE}"'/g' \
			"${STEAMAPPDIR}/${SERVER_CONFIG_PATH}"

cd "${STEAMAPPDIR}"

"./Holdfast NaW" -startserver \
				-batchmode \
				-nographics \
				--serverheadless \
				-screen-width "640" \
				-screen-height "480" \
				-screen-quality "Fastest" \
				-serverConfigFilePath "${SERVER_CONFIG_PATH}" \
				-logFile "${SERVER_LOG_PATH}" \
				-logArchivesDirectory "${SERVER_LOG_ARCHIVE_PATH}" \
				-p "${SERVER_PORT}" \
				{{ADDITIONAL_ARGS}}

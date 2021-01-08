###########################################################
# Dockerfile that builds a HoldfastNaW Gameserver
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="walentinlamonos@gmail.com"

ENV STEAMAPPID 1424230
ENV STEAMAPP holdfastnaw
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/CM2Walki/HoldfastNaW

# Create autoupdate config
# Remove packages and tidy up
RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.20.1-1.1 \
		ca-certificates=20190110 \
		libsqlite3-0=3.27.2-3 \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& wget "${DLURL}/master/etc/entry.sh" -O "${HOMEDIR}/entry.sh" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \	
	&& rm -rf /var/lib/apt/lists/*

ENV FPSMAX=300 \
	SERVER_PORT=20100 \
	STEAM_COM_PORT=8700 \
	STEAM_QUERY_PORT=27000 \
	SCREEN_QUALITY="Fastest" \
	SCREEN_WIDTH=640 \
	SCREEN_HEIGHT=480 \
	SERVER_REGION="europe" \
	SERVER_CONFIG_PATH="serverconfig_default.txt" \
	SERVER_LOG_PATH="logs_output/outputlog_server.txt" \
	SERVER_LOG_ARCHIVE_PATH="logs_archive/" \
	ADDITIONAL_ARGS="" \
	STEAMCMD_UPDATE_ARGS=""

USER ${USER}

VOLUME ${STEAMAPPDIR}

WORKDIR ${HOMEDIR}

# Replace {{ADDITIONAL_ARGS}} in entry.sh; Since passing nested bash variables to binary is cancer
ENTRYPOINT /bin/sed -i -e 's#{{ADDITIONAL_ARGS}}#'"${ADDITIONAL_ARGS}"'#g' "${HOMEDIR}/entry.sh" \
		&& /bin/bash "${HOMEDIR}/entry.sh"

# Expose ports
EXPOSE 20100 \
	8700 \
	27000

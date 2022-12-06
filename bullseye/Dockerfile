###########################################################
# Dockerfile that builds a HoldfastNaW Gameserver
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="walentinlamonos@gmail.com"

ENV STEAMAPPID 1424230
ENV STEAMAPP holdfastnaw
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/CM2Walki/HoldfastNaW

RUN set -x \
	# Install, update & upgrade packages
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.21-1+deb11u1 \
		ca-certificates=20210119 \
		tini=0.19.0-1 \
	&& mkdir -p "${STEAMAPPDIR}" \
	# Add entry scripts
	&& wget "${DLURL}/master/etc/entry.sh" -O "${HOMEDIR}/entry.sh" \
	&& wget "${DLURL}/master/etc/tinientry.sh" -O "${HOMEDIR}/tinientry.sh" \
	&& chmod +x "${HOMEDIR}/entry.sh" "${HOMEDIR}/tinientry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${HOMEDIR}/tinientry.sh" "${STEAMAPPDIR}" \
	# Clean up
	&& rm -rf /var/lib/apt/lists/*

ENV FPSMAX=120 \
	SERVER_PORT=20100 \
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

# Switch to user
USER ${USER}

VOLUME ${STEAMAPPDIR}

WORKDIR ${HOMEDIR}

# Overwrite Stopsignl for graceful server exits
STOPSIGNAL SIGINT

ENTRYPOINT ["tini", "-g", "--", "/home/steam/tinientry.sh"]

# Expose ports
EXPOSE 20100 \
	27000

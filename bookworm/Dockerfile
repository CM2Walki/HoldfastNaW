###########################################################
# Dockerfile that builds a HoldfastNaW Gameserver
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="walentinlamonos@gmail.com"

ENV STEAMAPPID 1424230
ENV STEAMAPP holdfastnaw
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

COPY "etc/entry.sh" "${HOMEDIR}/entry.sh"
COPY "etc/tinientry.sh" "${HOMEDIR}/tinientry.sh"

RUN set -x \
	# Install, update & upgrade packages
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		ca-certificates=20230311+deb12u1 \
		tini=0.19.0-1+b3 \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& chmod +x "${HOMEDIR}/entry.sh" "${HOMEDIR}/tinientry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${HOMEDIR}/tinientry.sh" "${STEAMAPPDIR}" \
	# Clean up
	&& rm -rf /var/lib/apt/lists/*

ENV SERVER_PORT=20100 \
	STEAM_QUERY_PORT=27000 \
	SERVER_REGION="europe" \
	SERVER_ADMIN_PASSWORD="defaultAdminPWReplace" \
 	SERVER_NAME="My Server" \
	SERVER_NETWORK_BROADCAST_MODE="Standard" \
 	SERVER_WELCOME_MESSAGE="The Server Welcome Message" \
 	SERVER_INTRO_TITLE="Welcome!" \
 	SERVER_INTRO_BODY="This is a server fresh of the assembly line" \
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

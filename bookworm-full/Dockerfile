###########################################################
# Dockerfile that includes the game server files - Not just the steamcmd wrapper
###########################################################
FROM cm2network/holdfastnaw:on-demand

RUN set -x \
    && bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" +login anonymous +app_update "${STEAMAPPID}" +quit

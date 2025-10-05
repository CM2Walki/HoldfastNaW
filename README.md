[![](https://img.shields.io/codacy/grade/80b3d1a6e05e440abfdc34354001b1bf.svg)](https://hub.docker.com/r/cm2network/holdfastnaw/) [![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/cm2network/holdfastnaw)](https://hub.docker.com/r/cm2network/holdfastnaw/) [![Docker Stars](https://img.shields.io/docker/stars/cm2network/holdfastnaw.svg)](https://hub.docker.com/r/cm2network/holdfastnaw/) [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/holdfastnaw.svg)](https://hub.docker.com/r/cm2network/holdfastnaw/) [![](https://img.shields.io/docker/image-size/cm2network/holdfastnaw)](https://hub.docker.com/r/cm2network/holdfastnaw/) [![Discord](https://img.shields.io/discord/747067734029893653)](https://discord.gg/7ntmAwM)
# Supported tags and respective `Dockerfile` links
-	[`on-demand`, `latest` (*bookworm/Dockerfile*)](https://github.com/CM2Walki/holdfastnaw/blob/master/bookworm/Dockerfile)
-	[`full` (*bookworm/Dockerfile*)](https://github.com/CM2Walki/holdfastnaw/blob/master/bookworm/Dockerfile)

# What is Holdfast: Nations At War ?
Fight on multiple fronts in Holdfast: Nations At War - A competitive multiplayer first and third person shooter set during the great Napoleonic Era. Charge into battle with over 150 players per server!

>  [Holdfast: NaW](https://store.steampowered.com/app/589290/Holdfast_Nations_At_War/)

<img src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/589290/9ed0c9a2b2db1ec48352d824329275468d2b8b0e/header.jpg" alt="logo" width="300"/></img>

# How to use this image
## Hosting a simple game server

Running on the *host* interface (recommended):<br/>
```console
$ docker run -d --net=host --name=holdfastnaw-dedicated cm2network/holdfastnaw
```

Running using a bind mount for data persistence on container recreation:
```console
$ mkdir -p $(pwd)/holdfastnaw-data
$ chmod 777 $(pwd)/holdfastnaw-data # Makes sure the directory is writeable by the unprivileged container user
$ docker run -d --net=host -v $(pwd)/holdfastnaw-data:/home/steam/holdfastnaw-dedicated/ --name=holdfastnaw-dedicated cm2network/holdfastnaw
```

Running multiple instances:
```console
$ docker run -d --net=host --name=holdfastnaw-dedicated2 cm2network/holdfastnaw
```

**It's also recommended to use "--cpuset-cpus=" to limit the game server to a specific core & thread.**<br/>
**The container will automatically update the game on startup, so if there is a game update just restart the container.**

# Configuration
## Environment Variables
Feel free to overwrite these environment variables, using -e (--env): 
```dockerfile
SERVER_PORT=20100 (UDP)
STEAM_QUERY_PORT=27000 (UDP, Optional: Legacy A2S Query port)
SERVER_REGION="europe"
SERVER_ADMIN_PASSWORD="defaultAdminPWReplace"
SERVER_NAME="My Server"
SERVER_NETWORK_BROADCAST_MODE="Standard" (Standard = Up to 250 players, Competitive = Higher tickrate - Limited to 64 players per server)
SERVER_WELCOME_MESSAGE="The Server Welcome Message"
SERVER_INTRO_TITLE="Welcome!"
SERVER_INTRO_BODY="This is a server fresh of the assembly line"
SERVER_CONFIG_PATH="serverconfig_default.txt"
SERVER_LOG_PATH="logs_output/outputlog_server.txt"
SERVER_LOG_ARCHIVE_PATH="logs_archive/"
STEAMCMD_UPDATE_ARGS="" (Gets appended here: +app_update [appid] [STEAMCMD_UPDATE_ARGS]; Example: "validate")
ADDITIONAL_ARGS="" (Pass additional arguments to server binary. Make sure to escape correctly!)
```
## Config
```console
$ docker exec -it holdfastnaw-dedicated nano /home/steam/holdfastnaw-dedicated/serverconfig_default.txt
```

If you want to learn more about configuring a Holdfast: Nations At War server check this [documentation](https://wiki.holdfastgame.com/Server_Configuration).

# Image Variants:

## `holdfastnaw:latest`, `holdfastnaw:on-demand`
This is the defacto image. A bare-minimum Holdfast: Nations At War dedicated server containing no 3rd party plugins. The game server files are downloaded (or updated) on container start, increasing start-up time. Ideal for static hosting in volumes or bind-mounts.<br/>

## `holdfastnaw:full`
Specialized version of `holdfastnaw:on-demand`. The game server files are pre-packaged within this image, trading storage for faster start-up times. Note: The game server files are still updated on container start. Ideal for container orchestration tools (Kubernetes, Docker Swarm, etc.).<br/>

# Contributors
[![Contributors Display](https://badges.pufler.dev/contributors/CM2Walki/HoldfastNaW?size=50&padding=5&bots=false)](https://github.com/CM2Walki/HoldfastNaW/graphs/contributors)

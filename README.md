[![](https://img.shields.io/codacy/grade/e201fa6b35074864b200eaf558563a22.svg)](https://hub.docker.com/r/cm2network/csgo/) [![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/cm2network/csgo)](https://hub.docker.com/r/cm2network/csgo/) [![Docker Stars](https://img.shields.io/docker/stars/cm2network/csgo.svg)](https://hub.docker.com/r/cm2network/csgo/) [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/csgo.svg)](https://hub.docker.com/r/cm2network/csgo/) [![](https://images.microbadger.com/badges/image/cm2network/csgo.svg)](https://microbadger.com/images/cm2network/csgo) [![Discord](https://img.shields.io/discord/747067734029893653)](https://discord.gg/7ntmAwM)
# Supported tags and respective `Dockerfile` links
-	[`latest` (*buster/Dockerfile*)](https://github.com/CM2Walki/holdfastnaw/blob/master/buster/Dockerfile)

# What is oldfast: Nations At War ?
Fight on multiple fronts in Holdfast: Nations At War - A competitive multiplayer first and third person shooter set during the great Napoleonic Era. Charge into battle with over 150 players per server!

>  [Holdfast:NaW](https://store.steampowered.com/app/589290/Holdfast_Nations_At_War/)

<img src="https://steamcdn-a.akamaihd.net/steam/apps/589290/capsule_616x353.jpg?t=1600279941" alt="logo" width="300"/></img>

# How to use this image
## Hosting a simple game server

Running on the *host* interface (recommended):<br/>
```console
$ docker run -d --net=host --name=holdfastnaw-dedicated -e SRCDS_TOKEN={YOURTOKEN} cm2network/holdfastnaw
```

Running using a bind mount for data persistence on container recreation:
```console
$ mkdir -p $(pwd)/holdfastnaw-data
$ chmod 777 $(pwd)/holdfastnaw-data # Makes sure the directory is writeable by the unprivileged container user
$ docker run -d --net=host -v $(pwd)/csgo-data:/home/steam/holdfastnaw-dedicated/ --name=holdfastnaw-dedicated cm2network/holdfastnaw
```

Running multiple instances (increment SRCDS_PORT and SRCDS_TV_PORT):
```console
$ docker run -d --net=host --name=holdfastnaw-dedicated2 cm2network/holdfastnaw
```

**It's also recommended to use "--cpuset-cpus=" to limit the game server to a specific core & thread.**<br/>
**The container will automatically update the game on startup, so if there is a game update just restart the container.**

# Configuration
## Environment Variables
Feel free to overwrite these environment variables, using -e (--env): 
```dockerfile

ADDITIONAL_ARGS="" (Pass additional arguments to srcds. Make sure to escape correctly!)
```
## Config
```console
$ docker exec -it holdfastnaw-dedicated nano /home/steam/holdfastnaw-dedicated/serverconfig_default.txt
```

If you want to learn more about configuring a Holdfast: Nations At War server check this [documentation](https://wiki.holdfastgame.com/Server_Configuration).

# Image Variants:

## `holdfastnaw:latest`
This is the defacto image. If you are unsure about what your needs are, you probably want to use this one. It is a bare-minimum hHoldfast: Nations At War dedicated server containing no 3rd party plugins.<br/>

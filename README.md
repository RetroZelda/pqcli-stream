<div align="center">
  
# pqcli-stream

<a href="https://www.twitch.tv/retrozelda" target="_blank"><img width="220px" src="https://img.shields.io/twitch/status/retrozelda?style=for-the-badge&logo=twitch&logoColor=EEEEEE&color=9146FF"></img></a>

*A headless setup for streaming Progress Quest to Twitch. Without a monitor.*

</div>

## Usage

1. Clone this repo
2. Clone and run [pqcli](https://github.com/rr-/pq-cli/) once and create a new character
3. Copy your save.dat file(usually found in ~/.config/pqcli) to the ./initial-save-data folder, although a default one is provided
4. Add your Twitch [stream key](https://www.twitch.tv/broadcast/dashboard/streamkey) to `compose.yaml`
5. Optionally, you may [set a server](https://github.com/tycrek/asciiquarium-stream/blob/master/stream.sh#L32) to use
6. Optionally, change what saved character to run(defaults to 1)
7. Optionally, change what [colors](https://critical.ch/xterm/) will be displayed
8. Run `docker compose up`

Optionally you can use the included systemd service

ALso, you can add music to a ./music folder to have it play
Save games can be recoverd from the docker volumes (e.g. located here: /var/lib/docker/volumes/pqcli-stream_pqcli-saves)

## How does this work?

It's a bit complicated to explain so I'll break down the main components:

- a **fake monitor** is created by [xvfb](https://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml)
- a **terminal** is emulated with [xterm](https://invisible-island.net/xterm/)
- a **live stream** is handled by [ffmpeg](https://ffmpeg.org/)
- finally, [**pqcli**](https://github.com/rr-/pq-cli/) is the star of the show

If you're interested in the original (but outdated) Reddit post, [visit the wiki](https://github.com/tycrek/asciiquarium-stream/wiki/Old-Reddit-Post).

### Notes

Originally forked from [asciiquarium-stream](https://github.com/tycrek/asciiquarium-stream)
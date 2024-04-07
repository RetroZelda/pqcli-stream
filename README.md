<div align="center">
  
# pqcli-stream

<a href="https://www.twitch.tv/retrozelda" target="_blank"><img width="220px" src="https://img.shields.io/twitch/status/retrozelda?style=for-the-badge&logo=twitch&logoColor=EEEEEE&color=9146FF"></img></a>

*A headless setup for streaming Progress Quest to Twitch. Without a monitor.*

</div>

## Usage

1. Clone this repo
2. Add your Twitch [stream key](https://www.twitch.tv/broadcast/dashboard/streamkey) to `compose.yaml`
3. Optionally, you may [set a server](https://github.com/tycrek/asciiquarium-stream/blob/master/stream.sh#L32) to use
4. Run `docker compose up`

## How does this work?

It's a bit complicated to explain so I'll break down the main components:

- a **fake monitor** is created by [xvfb](https://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml)
- a **terminal** is emulated with [xterm](https://invisible-island.net/xterm/)
- a **live stream** is handled by [ffmpeg](https://ffmpeg.org/)
- finally, [**pqcli**](https://github.com/rr-/pq-cli/) is the star of the show

If you're interested in the original (but outdated) Reddit post, [visit the wiki](https://github.com/tycrek/asciiquarium-stream/wiki/Old-Reddit-Post).

### Notes

Originally forked from [asciiquarium-stream](https://github.com/tycrek/asciiquarium-stream)
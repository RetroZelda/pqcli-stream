#!/bin/bash

DISPLAY=:1

# Change INRES and OUTRES values to match your config from above
INRES="1280x720"
OUTRES="1280x720"

# Target FPS
FPS="15"

# i-frame interval; should be double of FPS
GOP="30"

# Minimum i-frame interval; should be equal to fps
GOPMIN="15"

# Max is 6
THREADS="2"

# Constant bitrate (should be between 1000k - 3000k)
CBR="3000k"

# One of the many FFMPEG presets
QUALITY="fast"

# Audio rate bitrate
AUDIO_RATE="44100"

# Select a Twitch server to stream to. See this link for info:
# https://help.twitch.tv/s/twitch-ingest-recommendation
SERVER="jfk50"

MUSIC_FOLDER="/opt/pqcli-stream/music"

# Check if MUSIC_FOLDER is empty
concat_cmd=""
if [ -z "$(find "$MUSIC_FOLDER" -mindepth 1 -maxdepth 1)" ]; then
    echo "\"$MUSIC_FOLDER\" is empty"
else
	concat_list=$(printf "file '%s'\n" "$MUSIC_FOLDER"/*.mp3)
	concat_cmd="-f concat -stream_loop -1 -safe 0 -i <(echo '$concat_list')"
fi

# Stream with ffmpeg
# Leave these unchanged
ffmpeg_cmd="ffmpeg $concat_cmd \
	-f x11grab \
	-s '$INRES' \
	-r '$FPS' \
	-i $DISPLAY \
	-f alsa \
	-f flv \
	-ac 2 \
	-ar $AUDIO_RATE \
	-vcodec libx264 \
	-g $GOP \
	-keyint_min $GOPMIN \
	-b:v $CBR \
	-minrate $CBR \
	-maxrate $CBR \
	-pix_fmt yuv420p \
	-s $OUTRES \
	-preset $QUALITY \
	-tune film \
	-acodec libmp3lame \
	-threads $THREADS \
	-strict normal \
	-bufsize $CBR 'rtmp://$SERVER.contribute.live-video.net/app/$STREAM_KEY'"

echo $ffmpeg_cmd
eval "$ffmpeg_cmd"

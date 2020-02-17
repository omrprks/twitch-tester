#!/usr/bin/env sh

set -eo pipefail

set -a
[[ -f .env ]] && . .env
set +a

fatal() {
  COLOUR_RED="\033[0;31m"
  COLOUR_OFF="\033[0m"

  echo -e "${COLOUR_RED}[ERROR]${COLOUR_OFF} ${1}"
  echo "exiting..."
  exit 1
}

[[ ! -x "$(command -v ffmpeg)" ]] && fatal "ffmpeg not available"
[[ -z "${TWITCH_STREAM_KEY}" ]] && fatal "'TWITCH_STREAM_KEY' is required"

WIDTH=640
HEIGHT=320
RATE=15
CODEC=libx264

ffmpeg             \
  -re -f lavfi     \
  -i smptebars=size=${WIDTH}x${HEIGHT}:rate=${RATE} \
  -f flv           \
  -vcodec ${CODEC} \
  -pix_fmt yuv420p \
  -preset fast     \
  -r ${RATE}       \
  -g 30            \
  "rtmp://live.twitch.tv/app/${TWITCH_STREAM_KEY}"

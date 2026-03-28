#!/usr/bin/env bash
# Resample all WAV files in a directory to 24kHz mono.
# Qwen3-TTS codec pipeline requires exactly 24kHz — other sample rates
# cause silent training failures (loss decreases but output is degraded).
#
# Usage: bash scripts/resample_to_24k.sh /path/to/audio_dir
set -euo pipefail

INPUT_DIR="${1:?Usage: resample_to_24k.sh <audio_dir>}"
SAMPLE_RATE=24000

count=0
for f in "${INPUT_DIR}"/*.wav; do
  [ -f "$f" ] || continue
  rate=$(ffprobe -v error -select_streams a:0 -show_entries stream=sample_rate -of csv=p=0 "$f" 2>/dev/null || echo "unknown")
  if [ "$rate" != "$SAMPLE_RATE" ]; then
    tmp="${f%.wav}_24k_tmp.wav"
    ffmpeg -y -i "$f" -ar "$SAMPLE_RATE" -ac 1 "$tmp" -loglevel error
    mv "$tmp" "$f"
    count=$((count + 1))
  fi
done

echo "Resampled ${count} files to ${SAMPLE_RATE}Hz in ${INPUT_DIR}"

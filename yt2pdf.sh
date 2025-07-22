#!/bin/bash

TMP_DIR="yt_tmp_frames"
UNIQUE_DIR="yt_unique_frames"
OUTPUT_PDF="output.pdf"
FRAME_INTERVAL=2   # capture 1 frame every N seconds

# ==== CHECK DEPENDENCIES ====
for cmd in yt-dlp ffmpeg convert img2pdf; do
    if ! command -v $cmd &>/dev/null; then
        echo "[!] $cmd is not installed. Please install it first:"
        echo "sudo apt install ffmpeg imagemagick img2pdf"
        echo "pip install yt-dlp"
        exit 1
    fi
done

# ==== ASK FOR YOUTUBE URL ====
read -p "Enter YouTube video URL: " YT_URL
if [ -z "$YT_URL" ]; then
    echo "[!] No URL provided!"
    exit 1
fi

VIDEO_FILE="video.mp4"
echo "[*] Downloading video..."
yt-dlp -f mp4 -o "$VIDEO_FILE" "$YT_URL" || { echo "[!] Failed to download!"; exit 1; }

# ==== CREATE TEMP DIRS ====
rm -rf "$TMP_DIR" "$UNIQUE_DIR"
mkdir -p "$TMP_DIR" "$UNIQUE_DIR"

# ==== EXTRACT FRAMES EVERY N SECONDS ====
echo "[*] Extracting frames every $FRAME_INTERVAL seconds..."
ffmpeg -i "$VIDEO_FILE" -vf fps=1/$FRAME_INTERVAL "$TMP_DIR/frame_%04d.jpg" -hide_banner

# ==== FILTER UNIQUE FRAMES USING PERCEPTUAL HASH ====
echo "[*] Filtering truly unique frames..."
declare -A HASHES
for img in "$TMP_DIR"/*.jpg; do
    # Generate perceptual hash
    hash=$(convert "$img" -resize 8x8\! -colorspace Gray -format "%#" info:)
    
    if [[ -z "${HASHES[$hash]}" ]]; then
        # First time seeing this hash → keep it
        cp "$img" "$UNIQUE_DIR/"
        HASHES[$hash]=1
    else
        # Duplicate → skip
        echo "[=] Skipping duplicate frame: $img"
    fi
done

# ==== CREATE PDF ====
echo "[*] Creating PDF from unique frames..."
img2pdf "$UNIQUE_DIR"/*.jpg -o "$OUTPUT_PDF"

# ==== CLEANUP ====
echo "[*] Cleaning up..."
rm -rf "$TMP_DIR" "$UNIQUE_DIR" "$VIDEO_FILE"

echo "[✔️] Done! PDF saved as: $OUTPUT_PDF"

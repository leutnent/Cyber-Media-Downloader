#!/bin/bash

# Hacker Colors
G='\033[1;32m'
DG='\033[0;32m'
R='\033[1;31m'
NC='\033[0m'
C='\033[1;36m'

clear
echo -e "${G}  ███████╗ ██████╗  ██████╗██╗ █████╗ ███████╗${NC}"
echo -e "${G}  ██╔════╝██╔═══██╗██╔════╝██║██╔══██╗██╔════╝${NC}"
echo -e "${G}  ███████╗██║   ██║██║     ██║███████║███████╗${NC}"
echo -e "${G}  ╚════██║██║   ██║██║     ██║██╔══██║╚════██║${NC}"
echo -e "${G}  ███████║╚██████╔╝╚██████╗██║██║  ██║███████║${NC}"
echo -e "${G}  ╚══════╝ ╚═════╝  ╚═════╝╚═╝╚═╝  ╚═╝╚══════╝${NC}"
echo -e "${DG}========================================================${NC}"
echo -e "${G} [+] MULTI-PLATFORM CYBER EXTRACTOR READY${NC}"
echo -e "${DG}========================================================${NC}"

matrix_effect() {
    local msg="$1"
    local chars="/-\|"
    for i in {1..12}; do
        printf "\r${G} [${chars:i%4:1}] ${msg} ...${NC}"
        sleep 0.05
    done
    echo -e "\r${G} [✔] ${msg} [COMPLETED]          ${NC}"
}

URL="$1"
if [ -z "$URL" ]; then
    echo -ne "${G} [>] PASTE TARGET URL: ${NC}"
    read URL
fi

# المستشعر: التعرف التلقائي على الموقع لتحديد مسار الحفظ
if [[ "$URL" == *"tiktok.com"* || "$URL" == *"vt.tiktok"* || "$URL" == *"vm.tiktok"* ]]; then
    PLATFORM="TIKTOK"
    SAVE_DIR="/sdcard/msc/TikTok"
elif [[ "$URL" == *"instagram.com"* ]]; then
    PLATFORM="INSTAGRAM"
    SAVE_DIR="/sdcard/msc/Instagram"
elif [[ "$URL" == *"pinterest.com"* || "$URL" == *"pin.it"* ]]; then
    PLATFORM="PINTEREST"
    SAVE_DIR="/sdcard/msc/Pinterest"
elif [[ "$URL" == *"youtube.com"* || "$URL" == *"youtu.be"* ]]; then
    PLATFORM="YOUTUBE"
    SAVE_DIR="/sdcard/msc"
else
    PLATFORM="UNKNOWN / OTHER"
    SAVE_DIR="/sdcard/msc/Other"
fi

# إنشاء المجلد الخاص بالموقع إذا لم يكن موجوداً
mkdir -p "$SAVE_DIR"

matrix_effect "ANALYZING TARGET PLATFORM"
echo -e "${C} [!] PLATFORM DETECTED: ${PLATFORM}${NC}"
echo -e "${C} [!] SAVE LOCATION SET TO: ${SAVE_DIR}${NC}"

echo ""
echo -e "${G} ┌────────────────────────────────────────────────────┐${NC}"
echo -e "${G} │              SELECT PAYLOAD FORMAT                 │${NC}"
echo -e "${G} ├────────────────────────────────────────────────────┤${NC}"
echo -e "${G} │   [1] >> VIDEO (Best Quality - MP4)                │${NC}"
echo -e "${G} │   [2] >> AUDIO ONLY (MP3 - 320kbps)                │${NC}"
echo -e "${G} └────────────────────────────────────────────────────┘${NC}"
echo -ne "${G} [?] EXECUTE PROTOCOL [1-2]: ${NC}"
read choice

SAVE_TEMPLATE="$SAVE_DIR/%(title)s_[%(id)s].%(ext)s"
COMMON_ARGS="--no-mtime --no-playlist -o $SAVE_TEMPLATE"

echo ""
echo -e "${DG}--------------------------------------------------------${NC}"
echo -e "${G} [⚡] INITIATING DATA EXTRACTION... (Please wait)${NC}"

case $choice in
    1)
        yt-dlp $COMMON_ARGS -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" "$URL"
        ;;
    2)
        yt-dlp $COMMON_ARGS -x --audio-format mp3 --audio-quality 320K "$URL"
        ;;
    *)
        echo -e "${R} [!] ACCESS DENIED: INVALID OPTION!${NC}"
        exit 1
        ;;
esac

echo -e "${DG}--------------------------------------------------------${NC}"
matrix_effect "SYNCING ANDROID GALLERY & MUSIC PLAYER"

rm -f "$SAVE_DIR/.nomedia"
if command -v termux-media-scan >/dev/null 2>&1; then
    termux-media-scan -r "$SAVE_DIR"
fi
am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE -d "file://$SAVE_DIR" >/dev/null 2>&1

echo -e "${DG}========================================================${NC}"
echo -e "${G} [✔] PAYLOAD SECURED IN: ${SAVE_DIR}${NC}"
echo -e "${DG}========================================================${NC}"
read -p " Press [ENTER] to exit..."

# 🟢 Cyber Media Downloader for Termux

A powerful, automated, and multi-platform media extractor built for Termux. Features a full Hacker/Cyberpunk terminal UI and automatically sorts downloaded media into specific folders based on the target platform.

## 🚀 Features
- **Multi-Platform Support:** Downloads videos and audio from YouTube, TikTok, Instagram, and Pinterest.
- **Smart Directory Sorting:** Automatically creates folders and routes files to `/sdcard/msc/[Platform Name]`.
- **Watermark-Free:** Extracts original raw video files directly from TikTok servers.
- **Termux Integration:** Works directly from the Android "Share" menu (Zero typing required).
- **Cyberpunk UI:** Features a dynamic matrix-style loading animation and progress bar.

## 🛠️ Installation

1. Install required packages in Termux:
```bash
pkg update && pkg upgrade
pkg install yt-dlp ffmpeg -y

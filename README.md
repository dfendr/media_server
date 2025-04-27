# Media Server Setup

This repository contains configuration files and scripts to set up a media
server using Docker. It supports managing, organizing, and streaming various
media types, including movies, TV shows, audiobooks, and more.

## Features

- **Radarr**: Manage movie downloads.
- **Sonarr**: Manage TV/Anime.
- **Bazarr**: Subtitle management.
- **Jellyfin**: Media server for streaming.
- **Prowlarr**: Indexer for download clients.
- **Audiobookshelf**: Audiobook/podcast streaming.
- **Kavita**: Digital library for books/comics/manga.
- **Jellyseerr**: Request management for Jellyfin.
- **Homarr**: Dashboard to monitor/manage services.
- **qBittorrent**: Torrent client.
- **Watchtower**: Automated Docker updates.
- **FileFlows**: Automated media processing, including HEVC/AV1 transcoding.
- **Subsyncarr**: Subtitle syncing and automation.

---

## Prerequisites

1. **Install Docker and Docker Compose**:
   Ensure Docker is installed and Docker Compose is available.

2. **Setup `.env` File**:
   Set a base folder using `BASE_PATH` and configure relative paths for media and Docker config. All volumes will automatically expand from this root.

3. **Validate & Create Required Paths**:
   Run the setup script to automatically validate and create all required folders:

   ```bash
   ./setup.sh
   ```

---

## Usage

1. **Build and Start Containers**:
   Run the following command to start all services:

   ```bash
   docker compose up -d
   ```

2. **Verify Services**:
   Access the services via their respective ports in a browser. For example:

   - Radarr: `http://<your-ip>:7878`
   - Jellyfin: `http://<your-ip>:8096`
   - FileFlows: `http://<your-ip>:19200`

3. **Logs and Debugging**:
   Check logs if any service fails to start:

   ```bash
   docker compose logs <service-name>
   ```

---

## Updating Services

To update all services, use Watchtower or manually pull updates:

```bash
docker compose pull
docker compose up -d
```

---

## Folder Structure

All folder paths are defined in the `.env` file. This setup uses:

- `CONFIG_PATH`: Base path for all Docker config files
- `MEDIA_PATH`: Base path for media files (movies, TV, books, etc.)
- `DOWNLOADS_PATH`: Download client destination

Child directories (e.g., `fileflows/temp`, `jellyfin/config`) are derived automatically.

---

## Contributing

Feel free to submit issues or suggest improvements to this setup.

## License

This project is licensed under the MIT License.


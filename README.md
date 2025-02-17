# Media Server Setup

This repository contains configuration files and scripts to set up a media
server using Docker. It supports managing, organizing, and streaming various
media types, including movies, TV shows, audiobooks, and more.

## Features

- **Radarr**: Manage movie downloads.
- **Sonarr**: Manage TV and anime.
- **Bazarr**: Subtitle management.
- **Jellyfin**: Media server for streaming.
- **Prowlarr**: Indexer for download clients.
- **Audiobookshelf**: Audiobook/podcast streaming.
- **Kavita**: Digital library for books/comics/manga.
- **Jellyseerr**: Request management for Jellyfin.
- **Homarr**: Dashboard to monitor/manage services.
- **qBittorrent**: Torrent client.
- **Watchtower**: Automated Docker updates.

---

## Prerequisites

1. **Install Docker and Docker Compose**:
   Ensure Docker is installed and Docker Compose is available.

2. **Setup `.env` File**:
   Edit the `.env` file to set paths, ports, and user permissions.

3. **Validate Paths**:
   Use the provided script to validate or create required directories:

   ```
   ./validate_paths.sh
   ```

---

## Usage

1. **Build and Start Containers**:
   Run the following command to start all services:

   ```
   docker-compose up -d
   ```

2. **Verify Services**:
   Access the services via their respective ports in a browser. For example:

   - Radarr: `http://<your-ip>:7878`
   - Jellyfin: `http://<your-ip>:8096`

3. **Logs and Debugging**:
   Check logs if any service fails to start:

   ```
   docker-compose logs <service-name>
   ```

---

## Updating Services

To update all services, use `Watchtower` or manually pull updates:

```
docker-compose pull
docker-compose up -d
```

---

## Contributing

Feel free to submit issues or suggest improvements to this setup.

## License

This project is licensed under the MIT License.

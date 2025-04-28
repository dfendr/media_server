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

2. Sign up for [AirVPN](https://airvpn.org/).

## Prerequisites

1. On AirVPN's site, generate a config, and create one port forward.

2. Once you have the config, within `.env` configure your base path and relative paths for media and Docker config. All volumes
   will automatically exand from this root.

3. Within `.env`, setup the following, all found within the AirVPN config file.

- `AIRVPN_WIREGUARD_PRIVATE_KEY`
- `AIRVPN_WIREGUARD_ADDRESS`
- `AIRVPN_WIREGUARD_PRESHARED_KEY`

4. Set `AIRVPN_SERVER_COUNTRY` to whatever country you want the VPN to route through, and set both `FIREWALL_VPN_INPUT_PORTS` and
   `QBITTORRENT_PORT` to whatever port you have forwarded.

5. **Validate & Create Required Paths**:
   Run the setup script to automatically validate and create all required folders:

   ```bash
   chmod +x ./validate_paths.sh
   ./validate_paths.sh
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
   - Sonarr: `http://<your-ip>:8989`
   - Prowlarr: `http://<your-ip>:9696`
   - Jellyseerr: `http://<your-ip>:5055`
   - qBittorrent: `http://<your-ip>:8090`
   - Jellyfin: `http://<your-ip>:8096`
   - FileFlows: `http://<your-ip>:19200`

3. **Logs and Debugging**:
   Check logs if any service fails to start:

   ```bash
   docker compose logs <service-name>
   ```

---

## Setting up Services

There is some required setup in order to ensure that you have VPN funnelling working, and basic setup for
Prowlarr, Radarr, Sonarr, and Jellyseerr.

1. Within qBittorrent, set your listening port to whatever port you have forwarded.

2. Within Radarr:

   Navigate to **Settings &#8594; Media Management**. Set your root path to where you will store movies.

   Navigate to **Settings &#8594; Download Clients**. Set up qBittorrent as your download client.

3. Within Sonarr:

   Navigate to **Settings &#8594; Media Management**. Set a root path for shows and optionally a root path for anime.

   Navigatae to **Settings &#8594; Download Clients**. Set up qBittorrent as your download client.

4. Within Prowlarr:

   Navigate to **Settings &#8594; Download Clients** and set up qBittorrent as your download client here as well.

   Navigate to **Settings &#8594; Apps** and add both Radarr and Sonarr. You can find their API keys within their 
   respective clients under **Settings &#8594; General**.

   Lastly, add a few indexers and make sure to sync across all apps.

5. Within Jellyfin:

   Run through Jellyfin's setup wizard. If for whatever reason it does not default to the setup wizard, within your browser
   clear both the cache and site cookies for your media-hosting device.

6. Run through Jellyseer setup.

From here you can request content from Jellyseer without issue.


## Validating the VPN Tunnel

Run the following to validate that your VPN is connected. If the output address is different from
your routers external IP, you are connected.

```
docker exec -it airvpn-vpn wget -qO- ipinfo.io/ip
```

Run the following to view if your port is forwarded and listening:

```
docker exec -it airvpn-vpn netstat -tuln
```

The output should include your forwarded port.

Lastly, use a service such as [portchecker](https://portchecker.co/) to validate that the port is
open on the IP retrieved above.

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


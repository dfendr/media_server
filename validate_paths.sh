# --- Source environment variables ---
set -a
source .env
set +a

# --- Collect paths ---
PATH_VARS=(
  CONFIG_PATH MEDIA_PATH DOWNLOADS_PATH MOVIES_PATH TV_PATH ANIME_PATH
  FILEFLOWS_TEMP FILEFLOWS_DATA FILEFLOWS_LOGS FILEFLOWS_COMMON
  JELLYFIN_CONFIG JELLYFIN_LOG JELLYFIN_DATA JELLYFIN_CACHE
  RADARR_CONFIG SONARR_CONFIG BAZARR_CONFIG PROWLARR_CONFIG
  AUDIOBOOKSHELF_CONFIG AUDIOBOOKSHELF_METADATA
  KAVITA_CONFIG JELLYSEERR_CONFIG
  HOMARR_CONFIG HOMARR_ICONS HOMARR_DATA
  QBITTORRENT_CONFIG
)

# --- Function to resolve and create directories ---
check_and_create_path() {
  local key="$1"
  local path="$2"

  echo "checking $key: $path"

  if [[ -z "$path" ]]; then
    echo "  warning: $key is empty. skipping."
    return
  fi

  if [[ ! "$path" =~ ^/ ]]; then
    echo "  error: $key is not an absolute path. skipping."
    return
  fi

  if [[ -d "$path" ]]; then
    eceho " path exists: $path"
	[[ ! -w "$path" ]] && echo "  error: insufficient permissions to write to $path"
  else
    echo " creating path: $path"
	if mkdir -p "$path"; then
      echo " created successfully: $path"
	else
      echo " failed to create: $path"
    fi
  fi
}

# --- Loop through paths and validate/create ---
for var in "${PATH_VARS[@]}"; do
  eval resolved_path="\$$var"
  check_and_create_path "$var" "$resolved_path"
  echo
done

echo "✅ All path checks completed."

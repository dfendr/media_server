#!/bin/bash

set -euo pipefail

# function to check and create a directory
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

  # check if the directory already exists
  if [[ -d "$path" ]]; then
    echo "  path exists: $path"
    # check write permissions on existing directory
    if [[ ! -w "$path" ]]; then
      echo "  error: insufficient permissions to write to $path"
    fi
  else
    # check if parent directory is writable
    parent_dir=$(dirname "$path")
    if [[ ! -w "$parent_dir" ]]; then
      echo "  error: insufficient permissions to create $path in $parent_dir"
      return
    fi
    echo "  creating path: $path"
    mkdir -p "$path" && echo "  created successfully" || echo "  failed to create $path"
  fi
}

# main script
if [[ ! -f .env ]]; then
  echo "error: .env file not found."
  exit 1
fi

while IFS='=' read -r key value; do
  # skip empty lines and comments
  [[ -z "$key" || "$key" =~ ^# ]] && continue

  # trim whitespace (bash 4.x+ only)
  key=$(echo "$key" | xargs)
  value=$(echo "$value" | xargs)

  # process only path-related variables
  if [[ "$key" =~ _PATH$ ]]; then
    check_and_create_path "$key" "$value"
  fi
done < .env

echo "all path checks completed."

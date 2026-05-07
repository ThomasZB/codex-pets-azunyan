#!/bin/sh
set -eu

REPO_RAW="${REPO_RAW:-https://raw.githubusercontent.com/ThomasZB/codex-pets-azunyan/main}"
DEST_DIR="${CODEX_PETS_DIR:-${CODEX_HOME:-$HOME/.codex}/pets}"
PET="${1:-all}"

usage() {
  cat <<'EOF'
Install Azunyan Codex pet.

Usage:
  install.sh [all|azunyan|azunyan-80|azunyan-90|azunyan-105]

Environment:
  CODEX_PETS_DIR  Override install directory. Defaults to ${CODEX_HOME:-$HOME/.codex}/pets.
  REPO_RAW        Override raw GitHub base URL.

Examples:
  curl -fsSL https://raw.githubusercontent.com/ThomasZB/codex-pets-azunyan/main/install.sh | sh
  curl -fsSL https://raw.githubusercontent.com/ThomasZB/codex-pets-azunyan/main/install.sh | sh -s -- azunyan-90
EOF
}

download() {
  url="$1"
  out="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$out"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$out" "$url"
  else
    echo "Error: curl or wget is required." >&2
    exit 1
  fi
}

source_path_for_pet() {
  case "$1" in
    azunyan) echo "." ;;
    azunyan-80) echo "variants/azunyan-80" ;;
    azunyan-90) echo "variants/azunyan-90" ;;
    azunyan-105) echo "variants/azunyan-105" ;;
    *)
      echo "Error: unknown pet '$1'." >&2
      usage >&2
      exit 1
      ;;
  esac
}

install_pet() {
  pet="$1"
  src="$(source_path_for_pet "$pet")"
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' EXIT INT TERM

  if [ "$src" = "." ]; then
    base_url="$REPO_RAW"
  else
    base_url="$REPO_RAW/$src"
  fi

  echo "Installing $pet..."
  download "$base_url/pet.json" "$tmp_dir/pet.json"
  download "$base_url/spritesheet.webp" "$tmp_dir/spritesheet.webp"

  mkdir -p "$DEST_DIR/$pet"
  cp "$tmp_dir/pet.json" "$DEST_DIR/$pet/pet.json"
  cp "$tmp_dir/spritesheet.webp" "$DEST_DIR/$pet/spritesheet.webp"
  rm -rf "$tmp_dir"
  trap - EXIT INT TERM
  echo "Installed $pet to $DEST_DIR/$pet"
}

case "$PET" in
  -h|--help|help)
    usage
    exit 0
    ;;
  all)
    install_pet azunyan
    install_pet azunyan-80
    install_pet azunyan-90
    install_pet azunyan-105
    ;;
  azunyan|azunyan-80|azunyan-90|azunyan-105)
    install_pet "$PET"
    ;;
  *)
    echo "Error: unknown option or pet '$PET'." >&2
    usage >&2
    exit 1
    ;;
esac

echo "Done. Restart Codex if the pet does not appear immediately."

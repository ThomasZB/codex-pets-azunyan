#!/bin/sh
set -eu

REPO_RAW="${REPO_RAW:-https://raw.githubusercontent.com/ThomasZB/codex-pets-azunyan/main}"
DEST_DIR="${CODEX_PETS_DIR:-${CODEX_HOME:-$HOME/.codex}/pets}"
PET="${1:-azunyan}"

usage() {
  cat <<'EOF'
Install Azunyan Codex pet.

Usage:
  install.sh [azunyan]

Environment:
  CODEX_PETS_DIR  Override install directory. Defaults to ${CODEX_HOME:-$HOME/.codex}/pets.
  REPO_RAW        Override raw GitHub base URL.

Examples:
  curl -fsSL https://raw.githubusercontent.com/ThomasZB/codex-pets-azunyan/main/install.sh | sh
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

install_pet() {
  pet="$1"
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' EXIT INT TERM

  echo "Installing $pet..."
  download "$REPO_RAW/pet.json" "$tmp_dir/pet.json"
  download "$REPO_RAW/spritesheet.webp" "$tmp_dir/spritesheet.webp"

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
  azunyan)
    install_pet "$PET"
    ;;
  *)
    echo "Error: unknown option or pet '$PET'." >&2
    usage >&2
    exit 1
    ;;
esac

echo "Done. Restart Codex if the pet does not appear immediately."

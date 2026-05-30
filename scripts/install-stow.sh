#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if ! command -v stow >/dev/null 2>&1; then
  echo "GNU Stow не найден. Установите, например: sudo apt install stow" >&2
  exit 1
fi

stow -t "${HOME}/.config" config
exec stow -t "${HOME}" zsh tmux alacritty

#!/usr/bin/env bash
# Ouvre un terminal séparé pour Hugo. À appeler depuis Obsidian/Shell commands.
set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
SERVER_SCRIPT="$SCRIPT_DIR/hugo-serve-watch.sh"
PORT="${HUGO_PORT:-1313}"

# Évite d'ouvrir une seconde instance pour le port de prévisualisation par défaut.
if command -v lsof >/dev/null 2>&1 && lsof -nP -iTCP:"$PORT" -sTCP:LISTEN -t >/dev/null 2>&1; then
  printf '%s\n' "Un service écoute déjà sur http://localhost:$PORT/"
  case "$(uname -s)" in
    Darwin) open "http://localhost:$PORT/" ;;
    Linux) command -v xdg-open >/dev/null 2>&1 && xdg-open "http://localhost:$PORT/" >/dev/null 2>&1 || true ;;
  esac
  exit 0
fi

case "$(uname -s)" in
  Darwin)
    open -a Terminal "$SERVER_SCRIPT"
    ;;
  Linux)
    if command -v x-terminal-emulator >/dev/null 2>&1; then
      x-terminal-emulator -e bash "$SERVER_SCRIPT" >/dev/null 2>&1 &
    elif command -v mate-terminal >/dev/null 2>&1; then
      mate-terminal -- bash "$SERVER_SCRIPT" >/dev/null 2>&1 &
    else
      printf '%s\n' "Aucun émulateur de terminal compatible détecté. Lance : $SERVER_SCRIPT" >&2
      exit 1
    fi
    ;;
  *)
    printf '%s\n' "Système non pris en charge : $(uname -s)" >&2
    exit 1
    ;;
esac

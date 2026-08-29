#!/usr/bin/env bash
# Démarre Hugo depuis la racine du dépôt et surveille les modifications.
# Compatible Linux et macOS : le chemin du dépôt est déduit de ce script.
set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
SITE_DIR="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"

if ! command -v hugo >/dev/null 2>&1; then
  printf '%s\n' "Hugo est introuvable."
  case "$(uname -s)" in
    Darwin) printf '%s\n' "Installe-le avec : brew install hugo" ;;
    Linux)  printf '%s\n' "Installe Hugo avec le gestionnaire de paquets de cette distribution." ;;
  esac
  if [ -t 0 ]; then
    printf '%s' "Appuie sur Entrée pour fermer cette fenêtre… "
    read -r _
  fi
  exit 127
fi

cd "$SITE_DIR"
printf '%s\n' "Prévisualisation Hugo : http://localhost:1313/"
printf '%s\n' "Racine du site : $SITE_DIR"
printf '%s\n' "Arrêt : Ctrl+C"
exec hugo serve -w

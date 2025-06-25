#!/bin/bash
clear

# Colores
red='\033[1;31m'
green='\033[1;32m'
cyan='\033[1;36m'
reset='\033[0m'

lineas="=================================================================="
version="3.2"

# Título
printf "$red"
echo "$lineas"
echo "                                                                     
 __ __         ____                _           _ _____         _     
|  |  |___ _ _|    \ ___ _ _ _ ___| |___ ___ _| |     |_ _ ___|_|___ 
|_   _| . | | |  |  | . | | | |   | | . | .'| . | | | | | |_ -| |  _|
  |_| |___|___|____/|___|_____|_|_|_|___|__,|___|_|_|_|___|___|_|___|
                                                                     
"
echo "Version $version"
echo "$lineas"
printf "$reset"

# Menú
printf "$cyan"
echo "[1] Descargar Canción"
echo "[2] Descargar Playlist"
echo "[3] Salir"
printf "$reset"
read -p "Elige una opción: " opcion

case $opcion in
1)
	read -p "Pega la URL de la canción: " url
	if [ -z "$url" ]; then
		echo "❌ No ingresaste una URL."
		exit 1
	fi
	echo "🎧 Descargando canción..."
	yt-dlp -f bestaudio \
		--embed-thumbnail \
		--extract-audio --audio-format mp3 \
		--audio-quality 0 \
		--output "%(title)s.%(ext)s" "$url"
	echo "✅ Descarga finalizada en: $(pwd)"
	;;

2)
	read -p "Pega la URL de la playlist: " url
	if [ -z "$url" ]; then
		echo "❌ No ingresaste una URL."
		exit 1
	fi
	echo "🎶 Descargando playlist..."
	yt-dlp --ignore-errors -f bestaudio \
		--embed-thumbnail \
		--extract-audio --audio-format mp3 \
		--audio-quality 0 \
		--yes-playlist \
		--output "%(playlist_title)s/%(title)s.%(ext)s" "$url"
	echo "✅ Playlist descargada en: $(pwd)/$(yt-dlp --get-filename -o '%(playlist_title)s' "$url")"
	;;

3 | *)
	echo "$lineas"
	echo "👋 Adiós."
	echo "$lineas"
	exit 0
	;;
esac

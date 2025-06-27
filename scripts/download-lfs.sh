#!/bin/bash
# LFS-Download-Skript für GitHub Actions
# Dieses Skript lädt LFS-Dateien manuell über die GitHub API herunter

set -e

echo "=== GitHub LFS Downloader ==="

# Umgebungsvariablen prüfen
if [ -z "$GITHUB_TOKEN" ]; then
    echo "ERROR: GITHUB_TOKEN not set"
    exit 1
fi

if [ -z "$GITHUB_REPOSITORY" ]; then
    echo "ERROR: GITHUB_REPOSITORY not set"
    exit 1
fi

# Repository-Informationen
OWNER="${GITHUB_REPOSITORY%%/*}"
REPO="${GITHUB_REPOSITORY##*/}"
REF="${GITHUB_REF##*/}"

echo "Repository: $OWNER/$REPO"
echo "Reference: $REF"

# Funktion zum Herunterladen einer LFS-Datei
download_lfs_file() {
    local file_path="$1"
    local sha="$2"
    
    echo "Downloading LFS file: $file_path"
    
    # GitHub LFS API URL
    local api_url="https://api.github.com/repos/$OWNER/$REPO/git/blobs/$sha"
    
    # Erstelle Verzeichnisstruktur falls nötig
    local dir_path=$(dirname "$file_path")
    mkdir -p "$dir_path"
    
    # Lade die Datei herunter
    curl -s -L \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.git-lfs+json" \
        "$api_url" \
        -o "$file_path"
    
    # Prüfe ob Download erfolgreich
    if [ -f "$file_path" ]; then
        local size=$(stat -c%s "$file_path" 2>/dev/null || stat -f%z "$file_path")
        echo "Downloaded: $file_path ($size bytes)"
        return 0
    else
        echo "ERROR: Failed to download $file_path"
        return 1
    fi
}

# Versuche verschiedene Methoden zum LFS-Download
echo "=== Method 1: Standard Git LFS ==="
git lfs install
git lfs pull --include="*" || echo "Standard LFS pull failed"

echo -e "\n=== Method 2: Force LFS checkout ==="
git lfs fetch --all || echo "LFS fetch failed"
git lfs checkout --force || echo "LFS checkout failed"

echo -e "\n=== Method 3: Specific file download ==="
# Liste aller LFS-Dateien
git lfs ls-files --long | while IFS= read -r line; do
    if [[ $line == *"*"* ]]; then
        # Extrahiere Dateipfad
        file_path=$(echo "$line" | awk '{print $3}')
        
        # Prüfe ob Datei existiert und ob sie eine Pointer-Datei ist
        if [ -f "$file_path" ]; then
            size=$(stat -c%s "$file_path" 2>/dev/null || stat -f%z "$file_path")
            if [ "$size" -lt 1000 ]; then
                echo "Detected pointer file: $file_path ($size bytes)"
                
                # Versuche spezifischen Download
                echo "Attempting specific download for $file_path"
                git lfs pull --include="$file_path" || echo "Specific pull failed for $file_path"
            fi
        fi
    fi
done

echo -e "\n=== Final Verification ==="
# Prüfe kritische Dateien
critical_files=(
    "media/video/video-v-0-02-00.mp4"
)

for file in "${critical_files[@]}"; do
    if [ -f "$file" ]; then
        size=$(stat -c%s "$file" 2>/dev/null || stat -f%z "$file")
        echo "File: $file - Size: $size bytes"
        
        if [ "$size" -lt 10000 ]; then
            echo "WARNING: File $file is very small ($size bytes)"
            echo "Content preview:"
            head -3 "$file"
        else
            echo "SUCCESS: File $file appears to be downloaded correctly"
        fi
    else
        echo "ERROR: File $file not found"
    fi
done

echo "=== LFS Download Completed ==="

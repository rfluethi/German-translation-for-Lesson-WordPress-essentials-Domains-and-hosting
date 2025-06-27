#!/bin/bash
# GitHub LFS Downloader für GitHub Actions
# Lädt LFS-Dateien direkt über HTTP-API herunter

set -e

echo "=== GitHub LFS HTTP Downloader ==="

# Prüfe Umgebungsvariablen
if [ -z "$GITHUB_TOKEN" ]; then
    echo "ERROR: GITHUB_TOKEN nicht gesetzt"
    exit 1
fi

if [ -z "$GITHUB_REPOSITORY" ]; then
    echo "ERROR: GITHUB_REPOSITORY nicht gesetzt"
    exit 1
fi

# Repository-Info extrahieren
OWNER="${GITHUB_REPOSITORY%%/*}"
REPO="${GITHUB_REPOSITORY##*/}"
REF="${GITHUB_REF_NAME:-main}"

echo "Repository: $OWNER/$REPO"
echo "Reference: $REF"
echo "Token: ${GITHUB_TOKEN:0:10}..."

# Funktionen
download_file_via_api() {
    local file_path="$1"
    local output_path="${2:-$file_path}"
    
    echo "Downloading: $file_path"
    
    # Erstelle Verzeichnis falls nötig
    mkdir -p "$(dirname "$output_path")"
    
    # GitHub Contents API (kann LFS-Dateien direkt laden)
    local api_url="https://api.github.com/repos/$OWNER/$REPO/contents/$file_path?ref=$REF"
    
    # Lade Metadaten
    local response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "$api_url")
    
    # Prüfe ob es eine LFS-Datei ist
    if echo "$response" | jq -e '.download_url' > /dev/null; then
        # Normale Datei - lade direkt
        local download_url=$(echo "$response" | jq -r '.download_url')
        curl -L -o "$output_path" "$download_url"
    else
        # LFS-Datei - versuche andere Methoden
        echo "LFS file detected, trying alternative methods..."
        
        # Methode 1: Raw API mit Accept: application/octet-stream
        curl -L \
            -H "Authorization: token $GITHUB_TOKEN" \
            -H "Accept: application/octet-stream" \
            "https://api.github.com/repos/$OWNER/$REPO/contents/$file_path?ref=$REF" \
            -o "$output_path" 2>/dev/null || echo "Method 1 failed"
        
        # Prüfe Ergebnis
        if [ -f "$output_path" ]; then
            local size=$(stat -c%s "$output_path" 2>/dev/null || stat -f%z "$output_path")
            if [ "$size" -gt 1000 ]; then
                echo "Downloaded via method 1: $size bytes"
                return 0
            fi
        fi
        
        # Methode 2: GitHub LFS API direkt
        echo "Trying GitHub LFS API..."
        
        # Hole LFS-Pointer-Info
        local lfs_info=$(git lfs pointer --file="$file_path" 2>/dev/null || echo "")
        if [ -n "$lfs_info" ]; then
            local oid=$(echo "$lfs_info" | grep "oid sha256:" | cut -d: -f2 | tr -d ' ')
            local size=$(echo "$lfs_info" | grep "size" | cut -d' ' -f2)
            
            if [ -n "$oid" ] && [ -n "$size" ]; then
                echo "LFS OID: $oid"
                echo "LFS Size: $size"
                
                # GitHub LFS Batch API
                local batch_request="{\"operation\":\"download\",\"transfers\":[\"basic\"],\"objects\":[{\"oid\":\"$oid\",\"size\":$size}]}"
                local batch_response=$(curl -s \
                    -H "Authorization: token $GITHUB_TOKEN" \
                    -H "Accept: application/vnd.git-lfs+json" \
                    -H "Content-Type: application/vnd.git-lfs+json" \
                    -d "$batch_request" \
                    "https://github.com/$OWNER/$REPO.git/info/lfs/objects/batch")
                
                # Extrahiere Download-URL
                local download_url=$(echo "$batch_response" | jq -r '.objects[0].actions.download.href' 2>/dev/null || echo "")
                
                if [ -n "$download_url" ] && [ "$download_url" != "null" ]; then
                    echo "LFS Download URL: $download_url"
                    curl -L -o "$output_path" "$download_url"
                fi
            fi
        fi
    fi
    
    # Validiere Download
    if [ -f "$output_path" ]; then
        local final_size=$(stat -c%s "$output_path" 2>/dev/null || stat -f%z "$output_path")
        echo "Final size: $final_size bytes"
        
        if [ "$final_size" -gt 1000 ]; then
            echo "✅ Successfully downloaded: $file_path"
            return 0
        else
            echo "❌ Download too small: $file_path"
            return 1
        fi
    else
        echo "❌ Download failed: $file_path"
        return 1
    fi
}

# Hauptfunktion
main() {
    echo "=== Downloading LFS files ==="
    
    # Liste der kritischen Dateien
    critical_files=(
        "media/video/video-v-0-02-00.mp4"
    )
    
    # Lade kritische Dateien herunter
    for file in "${critical_files[@]}"; do
        echo "Processing: $file"
        download_file_via_api "$file" || echo "Failed to download $file"
    done
    
    # Versuche alle LFS-Dateien zu finden und herunterzuladen
    echo "=== Finding all LFS files ==="
    
    # Durchsuche .gitattributes nach LFS-Patterns
    if [ -f ".gitattributes" ]; then
        grep "filter=lfs" .gitattributes | while read -r line; do
            pattern=$(echo "$line" | awk '{print $1}')
            echo "LFS pattern: $pattern"
            
            # Finde Dateien, die dem Muster entsprechen
            find . -name "$pattern" -type f 2>/dev/null | while read -r found_file; do
                # Entferne führendes "./"
                clean_path="${found_file#./}"
                echo "Found LFS file: $clean_path"
                download_file_via_api "$clean_path" || echo "Failed to download $clean_path"
            done
        done
    fi
    
    echo "=== Download completed ==="
}

# Führe Hauptfunktion aus
main "$@"

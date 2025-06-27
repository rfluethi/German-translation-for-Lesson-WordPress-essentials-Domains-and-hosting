#!/bin/bash
# Test-Skript für Git LFS und Release-Workflow
# Dieses Skript testet lokale LFS-Konfiguration und zeigt wichtige Informationen

echo "=== Git LFS Test für Release-Workflow ==="
echo

# Prüfe Git LFS Installation
echo "1. Git LFS Installation:"
if command -v git-lfs &> /dev/null; then
    echo "✅ Git LFS ist installiert: $(git lfs version)"
else
    echo "❌ Git LFS ist NICHT installiert!"
    echo "   Installation: https://git-lfs.github.io/"
    exit 1
fi
echo

# Prüfe LFS-Tracking
echo "2. LFS-Tracking Konfiguration:"
echo "Aktuell getrackte Dateitypen:"
git lfs track
echo

# Prüfe LFS-Dateien
echo "3. LFS-verwaltete Dateien:"
lfs_files=$(git lfs ls-files | wc -l)
echo "Anzahl LFS-Dateien: $lfs_files"
echo

# Prüfe kritische große Dateien
echo "4. Kritische große Dateien:"
critical_files=(
    "media/video/video-v-0-02-00.mp4"
    "src/assets/video/video-v-0-02-00.cmproj"
)

for file in "${critical_files[@]}"; do
    if [ -f "$file" ]; then
        size=$(du -h "$file" | cut -f1)
        echo "✅ $file: $size"
        
        # Prüfe ob in LFS
        if git lfs ls-files | grep -q "$file"; then
            echo "   📦 In Git LFS verwaltet"
        else
            echo "   ⚠️  NICHT in Git LFS - könnte Probleme verursachen!"
        fi
    elif [ -d "$file" ]; then
        size=$(du -sh "$file" | cut -f1)
        echo "✅ $file/ (Verzeichnis): $size"
    else
        echo "❌ $file: Nicht gefunden"
    fi
done
echo

# Prüfe .gitattributes
echo "5. .gitattributes Konfiguration:"
if [ -f ".gitattributes" ]; then
    echo "✅ .gitattributes existiert"
    echo "LFS-Regeln:"
    grep "filter=lfs" .gitattributes | head -5
    echo "   (... weitere Regeln)"
else
    echo "❌ .gitattributes nicht gefunden!"
fi
echo

# Prüfe GitHub Actions Workflow
echo "6. GitHub Actions Workflow:"
if [ -f ".github/workflows/release.yml" ]; then
    echo "✅ Release-Workflow existiert"
    if grep -q "lfs: true" .github/workflows/release.yml; then
        echo "✅ LFS-Support aktiviert"
    else
        echo "❌ LFS-Support NICHT aktiviert!"
    fi
else
    echo "❌ Release-Workflow nicht gefunden!"
fi
echo

# Repository-Statistiken
echo "7. Repository-Statistiken:"
echo "Git-Repository-Größe: $(du -sh .git | cut -f1)"
echo "Arbeitsverzeichnis-Größe: $(du -sh --exclude=.git . | cut -f1)"
echo "LFS-Objekte lokal: $(find .git/lfs -name "*.git" 2>/dev/null | wc -l)"
echo

# Empfehlungen
echo "8. Empfehlungen für Release:"
echo "✅ Alle Commits gepusht?"
echo "✅ Alle LFS-Dateien hochgeladen? (git lfs push --all)"
echo "✅ GitHub Repository hat LFS aktiviert?"
echo "✅ Release-Tag erstellt?"
echo

echo "=== Test abgeschlossen ==="
echo "Falls alle Punkte ✅ zeigen, sollte das Release-Workflow korrekt funktionieren!"

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
echo ""

# LFS-Download Test
echo "9. LFS-Download Test (lokal):"
echo "Teste lokalen LFS-Download..."
if command -v git &> /dev/null; then
    # Simuliere den GitHub Actions Prozess
    echo "Simuliere GitHub Actions LFS-Download:"
    export GIT_LFS_SKIP_SMUDGE=0
    git lfs pull --include="*" || echo "❌ LFS Pull fehlgeschlagen"
    
    # Prüfe kritische Datei nach Pull
    if [ -f "media/video/video-v-0-02-00.mp4" ]; then
        size=$(stat -c%s "media/video/video-v-0-02-00.mp4" 2>/dev/null || stat -f%z "media/video/video-v-0-02-00.mp4")
        if [ "$size" -gt 1000000 ]; then
            echo "✅ LFS-Download Test erfolgreich ($size bytes)"
        else
            echo "❌ LFS-Download Test fehlgeschlagen - Datei zu klein ($size bytes)"
        fi
    else
        echo "❌ LFS-Download Test fehlgeschlagen - Datei nicht gefunden"
    fi
else
    echo "❌ Git nicht verfügbar für Test"
fi
echo ""

# GitHub Actions spezifische Checks
echo "10. GitHub Actions Kompatibilität:"
if grep -q "lfs: false" .github/workflows/release*.yml 2>/dev/null; then
    echo "✅ Workflow verwendet manuellen LFS-Download"
else
    echo "⚠️  Workflow könnte LFS-Probleme haben"
fi

if grep -q "GIT_LFS_SKIP_SMUDGE=0" .github/workflows/release*.yml 2>/dev/null; then
    echo "✅ Workflow setzt GIT_LFS_SKIP_SMUDGE=0"
else
    echo "⚠️  Workflow setzt möglicherweise nicht GIT_LFS_SKIP_SMUDGE=0"
fi
echo

echo "=== Test abgeschlossen ==="
echo ""
echo "🎯 PROBLEM ANALYSE:"
echo "Falls ZIP-Dateien zu klein sind (tutorial-videos.zip: 478 Bytes),"
echo "liegt das an GitHub Actions LFS-Token-Problemen."
echo ""
echo "🚀 LÖSUNG: Ultimate-Workflow mit 4 Fallback-Methoden:"
echo "1. Standard Git LFS"
echo "2. Repository Archive Download"  
echo "3. Custom HTTP LFS Downloader"
echo "4. Raw File Download + Dummy Files"
echo ""
echo "✅ Nächste Schritte:"
echo "1. git push origin main"
echo "2. Neues Release erstellen"
echo "3. Ultimate-Workflow sollte große ZIP-Dateien erzeugen"
echo ""
echo "Falls alle Punkte ✅ zeigen, sollte das Release-Workflow korrekt funktionieren!"

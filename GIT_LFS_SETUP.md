# Git LFS Setup für große Dateien

Dieses Repository verwendet Git Large File Storage (LFS) für die Verwaltung großer Dateien.

## Was ist Git LFS?

Git LFS ist eine Erweiterung für Git, die große Dateien effizient verwaltet, indem sie außerhalb des Git-Repositories gespeichert werden. Dies verbessert die Performance und reduziert die Repository-Größe.

## Große Dateien in diesem Repository

Die folgenden Dateien und Verzeichnisse werden mit Git LFS verwaltet:

- `media/video/video-v-0-02-00.mp4` (39MB)
- `src/assets/video/video-v-0-02-00.cmproj/` (225MB) - Alle Dateien in diesem Verzeichnis
- Alle MP4-Dateien in `src/assets/animation/`
- Alle WAV- und M4A-Audiodateien
- Projektdateien (.cmproj, .moho)
- Design-Dateien (.psd, .ai, .afdesign)

## Installation von Git LFS

### Für Entwickler

1. **Git LFS installieren:**
   ```bash
   # macOS (mit Homebrew)
   brew install git-lfs
   
   # Ubuntu/Debian
   sudo apt install git-lfs
   
   # Windows (mit Chocolatey)
   choco install git-lfs
   ```

2. **Git LFS initialisieren:**
   ```bash
   git lfs install
   ```

3. **Repository klonen:**
   ```bash
   git clone <repository-url>
   cd <repository-name>
   git lfs pull
   ```

### Für CI/CD (GitHub Actions)

Das Release-Skript ist bereits konfiguriert, um Git LFS zu verwenden:

```yaml
- name: Checkout repository with LFS
  uses: actions/checkout@v4
  with:
    lfs: true
```

## Release-Prozess

Bei der Erstellung eines Releases werden automatisch ZIP-Dateien erstellt, die alle LFS-Dateien enthalten:

1. **tutorial-docs.zip** - Dokumentation
2. **tutorial-assets.zip** - Alle Assets (inkl. LFS-Dateien)
3. **tutorial-videos.zip** - Video-Dateien (inkl. LFS-Dateien)
4. **tutorial-complete.zip** - Komplettes Projekt (inkl. aller LFS-Dateien)

## Hinweise für Entwickler

- **Neue große Dateien hinzufügen:** Git LFS erkennt automatisch Dateien basierend auf der `.gitattributes` Konfiguration
- **Dateien überprüfen:** `git lfs ls-files` zeigt alle mit LFS verwalteten Dateien
- **LFS-Status prüfen:** `git lfs status` zeigt den Status der LFS-Dateien
- **LFS-Dateien herunterladen:** `git lfs pull` lädt alle LFS-Dateien herunter

## Troubleshooting

### LFS-Dateien werden nicht heruntergeladen

```bash
git lfs pull
git lfs fetch --all
```

### LFS-Status überprüfen

```bash
git lfs status
git lfs ls-files
```

### Neue Dateien zu LFS hinzufügen

```bash
git lfs track "*.neuextension"
git add .gitattributes
git add datei.neuextension
```

## Weitere Informationen

- [Git LFS Dokumentation](https://git-lfs.github.com/)
- [Git LFS GitHub](https://github.com/git-lfs/git-lfs) 
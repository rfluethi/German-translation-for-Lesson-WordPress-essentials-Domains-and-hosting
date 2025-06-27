# GitHub Actions Release-Workflows für Git LFS

Dieses Repository enthält mehrere Ansätze für die Erstellung von Release-ZIP-Dateien mit Git LFS-Unterstützung.

## 🎯 Problem

Standard GitHub Actions haben Probleme beim Herunterladen von Git LFS-Dateien, was dazu führt, dass ZIP-Archive nur die kleinen Pointer-Dateien statt der echten großen Dateien enthalten.

## 🔧 Verfügbare Workflow-Ansätze

### 1. `release.yml` (Aktuell aktiv - Empfohlen)
**Ansatz:** Manueller LFS-Download mit Fallback-Mechanismus

**Funktionsweise:**
- Checkout ohne LFS
- Manuelle Git LFS-Konfiguration mit GitHub Token
- `GIT_LFS_SKIP_SMUDGE=0` für vollständigen Download
- Fallback: Fresh Clone bei Problemen
- Umfassende Validierung der Dateigrößen

**Vorteile:**
- ✅ Robuster Fallback-Mechanismus
- ✅ Detaillierte Fehlerbehandlung
- ✅ Funktioniert auch bei Token-Problemen

### 2. `release-simple.yml` (Alternative)
**Ansatz:** Verwendung externer Actions

**Funktionsweise:**
- `nschloe/action-cached-lfs-checkout` für LFS-Download
- Vereinfachte Konfiguration

**Probleme:**
- ❌ Abhängig von externer Action
- ❌ Möglicherweise nicht immer verfügbar

### 3. `release-old.yml` (Ursprünglich)
**Ansatz:** Standard checkout mit `lfs: true`

**Probleme:**
- ❌ GitHub Token has nicht genug Rechte für LFS
- ❌ ZIP-Dateien enthalten nur Pointer

## 🚀 Verwendung

### Automatisches Release
1. Gehe zu **GitHub → Releases → Create a new release**
2. Erstelle Tag (z.B. `v1.0.0`)  
3. Veröffentliche das Release
4. GitHub Actions erstellt automatisch ZIP-Dateien

### Manueller Test
1. Gehe zu **GitHub → Actions → Create Release with LFS Files (Working)**
2. Klicke **Run workflow**
3. ZIP-Dateien werden als Artifacts verfügbar

## 📦 Erstellte ZIP-Dateien

- **`tutorial-docs.zip`** - Dokumentation
- **`tutorial-assets.zip`** - Source-Assets mit großen Projektdateien
- **`tutorial-videos.zip`** - Video-Dateien (inkl. 39MB Hauptvideo)
- **`tutorial-complete.zip`** - Komplettes Projekt

## 🔍 Validierung

Das aktive Workflow führt umfassende Validierung durch:

### Vor ZIP-Erstellung
- Überprüfung der Dateigröße (muss > 1MB für Videos sein)
- Erkennung von Pointer-Dateien
- Fallback-Download bei Problemen

### Nach ZIP-Erstellung  
- Anzeige der ZIP-Größen
- Überprüfung der enthaltenen Video-Dateien
- Gesamtanzahl der Dateien pro ZIP

## 🛠 Troubleshooting

### Problem: ZIP-Dateien zu klein
**Lösung:** Überprüfe GitHub Actions Logs auf LFS-Download-Fehler

### Problem: "CRITICAL ERROR: Could not download video file properly"
**Ursachen:**
- GitHub LFS-Quota überschritten
- Repository-LFS nicht aktiviert
- Token-Berechtigungen unzureichend

**Lösungen:**
1. Überprüfe LFS-Quota in Repository-Settings
2. Stelle sicher, dass Git LFS im Repository aktiviert ist
3. Bei persistenten Problemen: Personal Access Token verwenden

### Problem: Workflow schlägt fehl
**Debug-Schritte:**
1. Führe `./test-lfs-release.sh` lokal aus
2. Überprüfe GitHub Actions Logs
3. Validiere LFS-Dateien mit `git lfs ls-files`

## 📋 Checkliste vor Release

- [ ] `./test-lfs-release.sh` ausgeführt - alle ✅
- [ ] Alle Commits gepusht (`git push`)
- [ ] Alle LFS-Dateien hochgeladen (`git lfs push --all`)
- [ ] GitHub Repository hat LFS aktiviert
- [ ] Test-Workflow manuell ausgeführt und erfolgreich

## 🎉 Erfolgreiche Releases erkennen

✅ **Erfolgreiche ZIP-Dateien:**
- `tutorial-videos.zip` > 30MB (enthält 39MB Hauptvideo)
- `tutorial-assets.zip` > 200MB (enthält große .cmproj Dateien)
- Workflow-Logs zeigen "SUCCESS: Video file downloaded correctly"

❌ **Problematische ZIP-Dateien:**
- `tutorial-videos.zip` < 1MB (nur Pointer-Dateien)
- Workflow-Logs zeigen "ERROR: File too small"
- ZIP-Archive enthalten nur Text-Dateien statt Binärdateien

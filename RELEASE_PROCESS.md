# Release Process mit Git LFS Support

Dieses Dokument beschreibt den optimierten Release-Prozess für das Repository, der sicherstellt, dass alle großen Dateien (Git LFS) korrekt in die Release-ZIP-Dateien aufgenommen werden.

## 🎯 Problem gelöst

**Früher:** ZIP-Dateien enthielten nur LFS-Pointer-Dateien (kleine Textdateien)
**Jetzt:** ZIP-Dateien enthalten die vollständigen großen Dateien (Videos, Audio, etc.)

## 🚀 Automatischer Release-Prozess

### 1. Release erstellen
1. Gehe zu **GitHub > Releases > Create a new release**
2. Erstelle einen neuen Tag (z.B. `v1.0.0`)
3. Füge Release-Notizen hinzu
4. Klicke **Publish release**

### 2. Automatische ZIP-Erstellung
Das GitHub Actions Workflow erstellt automatisch folgende ZIP-Dateien:

- **`tutorial-docs.zip`** - Alle Dokumentationen
- **`tutorial-assets.zip`** - Source-Assets inkl. große Projektdateien  
- **`tutorial-videos.zip`** - Alle Videos inkl. große MP4-Dateien
- **`tutorial-complete.zip`** - Komplettes Projekt mit allen Dateien

### 3. LFS-Dateien werden vollständig inkludiert

Das Workflow stellt sicher, dass:
- ✅ **Alle LFS-Dateien vollständig heruntergeladen** werden
- ✅ **Große Video-Dateien** (z.B. `video-v-0-02-00.mp4`) in voller Größe inkludiert werden
- ✅ **Projektdateien** (z.B. `.cmproj` Verzeichnisse) vollständig inkludiert werden
- ✅ **Validierung** dass keine Pointer-Dateien in ZIP-Archive gelangen

## 🔧 Manuelle Release-Erstellung (Testing)

Für Tests kann das Workflow auch manuell ausgelöst werden:

1. Gehe zu **GitHub > Actions > Create and upload ZIP files for release**
2. Klicke **Run workflow**
3. ZIP-Dateien werden als Artifacts hochgeladen

## 📦 Verfügbare ZIP-Dateien

### tutorial-docs.zip
- Enthält: `docs/` Ordner
- Größe: ~Wenige MB
- Inhalt: Dokumentation, Storyboards, Quiz

### tutorial-assets.zip  
- Enthält: `src/` Ordner
- Größe: ~Größere Dateien durch LFS-Inhalte
- Inhalt: Design-Assets, Animations, große Projektdateien

### tutorial-videos.zip
- Enthält: `media/video/` Ordner  
- Größe: ~Sehr groß durch Video-Dateien
- Inhalt: Alle Video-Dateien in voller Qualität

### tutorial-complete.zip
- Enthält: Komplettes Repository
- Größe: ~Maximal durch alle LFS-Dateien
- Inhalt: Alles außer `.git` und `zip/` Ordner

## 🛠 Technische Details

### LFS-Download-Prozess
Das Workflow führt folgende Schritte aus:

1. **Repository checkout** mit LFS-Support
2. **Git LFS Installation** und Konfiguration  
3. **Vollständiger LFS-Download** aller Dateien
4. **Validierung** dass große Dateien korrekt heruntergeladen wurden
5. **ZIP-Erstellung** mit vollständigen Dateien
6. **Upload** zu GitHub Release

### Validierung großer Dateien
Vor ZIP-Erstellung wird geprüft:
- Dateigröße > 1KB (Pointer-Dateien sind kleiner)
- Dateityp entspricht Erwartung (kein Text für Binärdateien)
- Vollständiger Inhalt vorhanden

## 🔍 Troubleshooting

### Problem: ZIP-Datei zu klein
**Lösung:** Überprüfe GitHub Actions Logs auf LFS-Download-Fehler

### Problem: Pointer-Dateien in ZIP
**Lösung:** Workflow bricht ab und zeigt Fehlermeldung mit Pointer-Inhalt

### Problem: LFS-Quota überschritten
**Lösung:** GitHub LFS-Limits in Repository-Settings prüfen

## 📋 Checkliste für Release

- [ ] Alle Änderungen committed und gepusht
- [ ] LFS-Dateien sind korrekt hochgeladen (`git lfs ls-files`)
- [ ] Release-Tag erstellt
- [ ] GitHub Actions Workflow erfolgreich abgeschlossen
- [ ] ZIP-Dateien sind in erwarteter Größe vorhanden
- [ ] Testdownload einer ZIP-Datei durchgeführt

## 🎉 Ergebnis

Benutzer können jetzt:
- Vollständige ZIP-Dateien mit allen großen Dateien herunterladen
- Videos in voller Qualität erhalten  
- Projektdateien ohne zusätzliche LFS-Setup verwenden
- Alle Tutorial-Materialien offline nutzen

#!/bin/bash

# Markdown-Lint Korrekturskript für alle .md Dateien

echo "🔧 Behebe alle Markdown-Lint-Fehler..."

# Funktion zum Korrigieren einer einzelnen Datei
fix_markdown_file() {
    local file="$1"
    echo "📝 Korrigiere: $file"
    
    # Temporäre Datei erstellen
    local temp_file=$(mktemp)
    
    # 1. Zeilenlänge auf 80 Zeichen begrenzen (außer für URLs und Code-Blöcke)
    # 2. Trailing Spaces entfernen
    # 3. Mehrfache Leerzeilen auf eine reduzieren
    # 4. Newline am Ende hinzufügen
    # 5. Listen mit Leerzeilen umgeben
    # 6. Überschriften mit Leerzeilen umgeben
    
    awk '
    BEGIN { 
        in_code_block = 0
        in_list = 0
        prev_was_heading = 0
        prev_was_list = 0
        prev_was_blank = 0
    }
    
    {
        # Code-Blöcke erkennen
        if ($0 ~ /^```/) {
            in_code_block = !in_code_block
            print $0
            next
        }
        
        # In Code-Blöcken nichts ändern
        if (in_code_block) {
            print $0
            next
        }
        
        # Trailing Spaces entfernen
        gsub(/[ \t]+$/, "")
        
        # Leerzeile
        if ($0 ~ /^[ \t]*$/) {
            if (!prev_was_blank) {
                print ""
                prev_was_blank = 1
            }
            next
        }
        
        # Überschrift erkennen
        if ($0 ~ /^#{1,6}[ \t]/) {
            if (!prev_was_blank) {
                print ""
            }
            print $0
            prev_was_heading = 1
            prev_was_blank = 0
            next
        }
        
        # Liste erkennen
        if ($0 ~ /^[ \t]*[-*+][ \t]/ || $0 ~ /^[ \t]*[0-9]+\.[ \t]/) {
            if (!prev_was_blank && !prev_was_list) {
                print ""
            }
            print $0
            prev_was_list = 1
            prev_was_blank = 0
            next
        }
        
        # Normale Zeile - Zeilenlänge prüfen
        if (length($0) > 80) {
            # URLs und spezielle Inhalte nicht umbrechen
            if ($0 ~ /https?:\/\// || $0 ~ /`.*`/) {
                print $0
            } else {
                # Zeile umbrechen
                split($0, words, " ")
                line = ""
                for (i = 1; i <= length(words); i++) {
                    if (length(line " " words[i]) > 80) {
                        if (line != "") print line
                        line = words[i]
                    } else {
                        if (line == "") line = words[i]
                        else line = line " " words[i]
                    }
                }
                if (line != "") print line
            }
        } else {
            print $0
        }
        
        prev_was_heading = 0
        prev_was_list = 0
        prev_was_blank = 0
    }
    
    END {
        # Newline am Ende hinzufügen
        print ""
    }
    ' "$file" > "$temp_file"
    
    # Datei ersetzen
    mv "$temp_file" "$file"
}

# Alle .md Dateien finden und korrigieren
find . -name "*.md" -type f | while read file; do
    fix_markdown_file "$file"
done

echo "✅ Alle Markdown-Dateien korrigiert!"

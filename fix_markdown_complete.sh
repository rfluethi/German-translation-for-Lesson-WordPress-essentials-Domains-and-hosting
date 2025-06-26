#!/bin/bash

# Vollständiges Markdown-Lint Korrekturskript

echo "🔧 Behebe ALLE Markdown-Lint-Fehler..."

fix_markdown_file() {
    local file="$1"
    echo "📝 Korrigiere: $file"
    
    # Temporäre Datei
    local temp_file=$(mktemp)
    
    # 1. Erste Zeile sollte H1 sein (MD041)
    # 2. Zeilenlänge auf 80 begrenzen (MD013)
    # 3. Trailing Spaces entfernen (MD009)
    # 4. Mehrfache Leerzeilen reduzieren (MD012)
    # 5. Listen mit Leerzeilen umgeben (MD032)
    # 6. Überschriften mit Leerzeilen umgeben (MD022)
    # 7. Newline am Ende (MD047)
    
    awk '
    BEGIN { 
        in_code_block = 0
        in_list = 0
        prev_was_heading = 0
        prev_was_list = 0
        prev_was_blank = 0
        first_line = 1
        line_count = 0
    }
    
    {
        line_count++
        
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
        
        # Erste Zeile sollte H1 sein (MD041)
        if (first_line && $0 ~ /^##[ \t]/) {
            gsub(/^##/, "#", $0)
            first_line = 0
        } else if (first_line) {
            first_line = 0
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
            if ($0 ~ /https?:\/\// || $0 ~ /`.*`/ || $0 ~ /^[ \t]*[-*+]/) {
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
    
    mv "$temp_file" "$file"
}

# Alle .md Dateien finden und korrigieren
find . -name "*.md" -type f | while read file; do
    fix_markdown_file "$file"
done

echo "✅ Alle Markdown-Dateien korrigiert!"

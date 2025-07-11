#!/bin/bash

TARGET_DIR="/home/kurs"
NUM_FILES=25
NUM_DIRS=10

EXTENSIONS=(txt sh bin log zip json html md conf dat bak tmp weird csv)

# Funkcja do tworzenia losowego pliku w losowym katalogu
create_random_file() {
    local filename="$1"
    local extension="$2"
    local subdir=$(find "$TARGET_DIR" -type d | shuf -n 1)
    local fullpath="$subdir/$filename.$extension"

    case "$extension" in
        txt|log|md|conf)
            echo "Plik testowy typu .$extension: $filename" > "$fullpath"
            ;;
        sh)
            echo -e "#!/bin/bash\necho 'Skrypt $filename'" > "$fullpath"
            chmod +x "$fullpath"
            ;;
        bin|dat|bak|tmp|weird)
            head -c 512 /dev/urandom > "$fullpath"
            ;;
        json)
            echo "{\"name\": \"$filename\", \"type\": \"$extension\"}" > "$fullpath"
            ;;
        html)
            echo "<html><body><h1>Test $filename</h1></body></html>" > "$fullpath"
            ;;
        zip)
            echo "Archiwum $filename" > "$TARGET_DIR/temp_$filename.txt"
            zip -q "$fullpath" "$TARGET_DIR/temp_$filename.txt"
            rm "$TARGET_DIR/temp_$filename.txt"
            ;;
        csv)
            echo "id,name,value" > "$fullpath"
            echo "1,$filename,42" >> "$fullpath"
            ;;
    esac
}

# Tworzenie katalogów w losowych miejscach
mkdir -p "$TARGET_DIR"
for i in $(seq 1 $NUM_DIRS); do
    PARENT=$(find "$TARGET_DIR" -type d | shuf -n 1)
    DIR_NAME=$(head /dev/urandom | tr -dc a-z0-9 | head -c 6)
    mkdir -p "$PARENT/$DIR_NAME"
done

# Tworzenie plików w losowych katalogach
for i in $(seq 1 $NUM_FILES); do
    NAME=$(head /dev/urandom | tr -dc a-z0-9 | head -c 8)
    EXT=${EXTENSIONS[$RANDOM % ${#EXTENSIONS[@]}]}
    create_random_file "$NAME" "$EXT"
done

# Kopiowanie plików CSV do losowych katalogów
for file in pixar_films.csv academy.csv pixar_people.csv; do
    DEST=$(find "$TARGET_DIR" -type d | shuf -n 1)
    cp "$file" "$DEST/"
done

# Nadanie właściciela
chown -R kurs:kurs "$TARGET_DIR"

echo "Rozszerzony bałagan utworzony w $TARGET_DIR i przypisany użytkownikowi 'kurs'."

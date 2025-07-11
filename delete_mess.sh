#!/bin/bash

TARGET_DIR="/home/kurs"

if [ -d "$TARGET_DIR" ]; then
    rm -rf "$TARGET_DIR"
    echo "Katalog $TARGET_DIR został usunięty."
else
    echo "Katalog $TARGET_DIR nie istnieje."
fi

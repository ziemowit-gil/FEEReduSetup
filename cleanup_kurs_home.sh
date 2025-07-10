#!/bin/bash

# This script deletes all files and folders in /home/kurs
# but does not delete the /home/kurs directory itself

TARGET_DIR="/home/kurs"

if [ -d "$TARGET_DIR" ]; then
    echo "Cleaning contents of $TARGET_DIR..."
    rm -rf "$TARGET_DIR"/*
    rm -rf "$TARGET_DIR"/.[!.]* "$TARGET_DIR"/..?* 2>/dev/null
    echo "Cleanup complete."
else
    echo "Directory $TARGET_DIR does not exist."
fi

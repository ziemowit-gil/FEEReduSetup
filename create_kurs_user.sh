#!/bin/bash

# 1. Create a new user 'kurs' with a predefined password
sudo useradd -m kurs
echo 'kurs:Eduk@cja2025!@#$' | sudo chpasswd

# 2. Add the user to 'sudo' and 'root' groups
sudo usermod -aG sudo kurs
sudo usermod -aG root kurs

# 3. Create 30 folders in the user's home directory
for i in {1..30}; do
    sudo -u kurs mkdir -p /home/kurs/folder$i
done

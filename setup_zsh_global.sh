#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install Zsh if not already installed
if ! command -v zsh &> /dev/null; then
    echo "Installing Zsh..."
    sudo apt update
    sudo apt install -y zsh
else
    echo "Zsh is already installed."
fi

# Set Zsh as the default shell for all users
echo "Setting Zsh as the default shell for all users..."
for user in $(cut -d: -f1 /etc/passwd); do
    user_home=$(eval echo ~$user)
    if [ -d "$user_home" ]; then
        sudo chsh -s $(which zsh) $user
    fi
done

# Install Oh My Zsh for the current user
echo "Installing Oh My Zsh..."
export RUNZSH=no
export CHSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# Install zsh-autosuggestions
echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting
echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting

# Install powerlevel10k theme
echo "Installing powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k

# Update .zshrc to use plugins and theme
echo "Configuring .zshrc..."
sed -i 's/^plugins=(.*)$/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

echo "Zsh configuration complete. Please restart your terminal or run 'zsh' to start using Zsh."

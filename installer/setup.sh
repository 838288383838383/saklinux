#!/bin/bash
# 🌸 SakLinux Base Setup
# This runs during Docker build to create the rootfs

set -e

echo "🌸 Building SakLinux rootfs..."

# System packages
apt update && apt upgrade -y
apt install -y \
    # Core
    sudo curl wget git ca-certificates gnupg \
    lsb-release software-properties-common \
    # Build tools
    build-essential gcc g++ make cmake \
    # Languages
    nodejs npm python3 python3-pip python3-venv \
    golang rustc cargo \
    # Editors
    vim neovim nano \
    # CLI tools
    htop tmux tree unzip zip p7zip-full \
    ripgrep fd-find fzf bat eza zoxide \
    jq yq \
    # Network
    openssh-client net-tools dnsutils \
    # Sakura
    figlet lolcat \
    # WSL integration
    wslu

# Create saklinux user
useradd -m -s /bin/bash -G sudo sakura
echo "sakura:sakura" | chpasswd
echo "sakura ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/sakura

# Set locale
locale-gen en_US.UTF-8
echo "LANG=en_US.UTF-8" > /etc/default/locale

# Copy overlay files
cp -r /root/rootfs/* / 2>/dev/null || true
rm -rf /root/rootfs

echo "🌸 SakLinux rootfs built successfully!"

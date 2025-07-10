#!/bin/bash
set -e

echo "🔧 Configuring Nix..."

# Enable experimental features
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' > ~/.config/nix/nix.conf

# System-wide config (if needed)
if [ -w /etc/nix ] || sudo -n true 2>/dev/null; then
    sudo mkdir -p /etc/nix
    echo 'experimental-features = nix-command flakes' | sudo tee /etc/nix/nix.conf > /dev/null
fi

echo "📦 Setting up project environment..."
echo "use flake" > .envrc
direnv allow

echo "🚀 Testing Nix environment..."
nix develop --command echo "✅ Nix flakes working perfectly!"
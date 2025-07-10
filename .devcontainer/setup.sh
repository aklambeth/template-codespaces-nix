#!/bin/bash
set -e

echo "🔧 Setting up Nix and direnv..."

# Configure Nix experimental features
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' > ~/.config/nix/nix.conf

# Install direnv via Nix (most reliable method)
echo "📦 Installing direnv..."
nix profile install nixpkgs#direnv

# Add Nix profiles to PATH if not already there
export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"

# Add direnv hook to bashrc
echo 'export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc

# Source bashrc to activate in current session
source ~/.bashrc

# Now create and allow .envrc
echo "📝 Setting up .envrc..."
echo "use flake" > .envrc
direnv allow

echo "✅ Setup complete!"
echo "💡 Try: cd / && cd back to test auto-loading"
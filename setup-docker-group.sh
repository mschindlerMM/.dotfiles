#!/bin/bash

# Ensure script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "❗ Please run as root or with sudo"
  exit 1
fi

# Get the currently logged-in user
USERNAME=$(logname)

# Create docker group if it doesn't exist
if ! getent group docker > /dev/null; then
  echo "🔧 Creating 'docker' group..."
  groupadd docker
fi

# Add user to docker group
echo "➕ Adding user '$USERNAME' to the 'docker' group..."
usermod -aG docker "$USERNAME"

echo "✅ User '$USERNAME' added to 'docker' group."

# Restart Docker (optional)
read -p "🔄 Would you like to restart Docker now? [y/N]: " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
  systemctl restart docker && echo "🚀 Docker restarted successfully."
fi

# Suggest logout/login
echo "🔁 Please log out and back in (or reboot) for group changes to take effect."

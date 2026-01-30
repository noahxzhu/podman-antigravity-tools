#!/bin/bash
set -e

# Ensure we are in the project root
cd "$(dirname "$0")"

# Service Name
SERVICE_NAME="antigravity-manager"

echo ">>> 1. Pulling latest image..."
podman pull docker.io/lbjlaq/antigravity-manager:latest

echo ">>> 2. Creating data directory..."
mkdir -p "$HOME/.antigravity_tools"

echo ">>> 3. Installing Quadlet service file..."
SYSTEMD_DIR="$HOME/.config/containers/systemd"
mkdir -p "$SYSTEMD_DIR"
cp "${SERVICE_NAME}.container" "$SYSTEMD_DIR/"

echo ">>> 4. Reloading systemd..."
systemctl --user daemon-reload

echo ">>> 5. Restarting service..."
systemctl --user restart "$SERVICE_NAME"

echo ">>> 6. Enabling User Linger..."
loginctl enable-linger "$USER" || echo "Warning: Could not enable linger."

echo ""
echo ">>> Deployment Complete! Checking status..."
systemctl --user status "$SERVICE_NAME" --no-pager

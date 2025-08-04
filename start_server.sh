#!/bin/bash

# Default workspace directory
WORKSPACE_DIR="/data"

# Create necessary directories with proper permissions
mkdir -p "$WORKSPACE_DIR/.vscode-server/extensions"
mkdir -p "$WORKSPACE_DIR/.vscode-server/data/User"
mkdir -p "$WORKSPACE_DIR/.vscode-server/data/Machine"
mkdir -p "$WORKSPACE_DIR/.vscode-server/data/User/globalStorage"
mkdir -p "$WORKSPACE_DIR/.vscode-server/data/User/History"
mkdir -p "$WORKSPACE_DIR/.vscode-server/data/logs"

# Ensure correct permissions
chmod -R 755 "$WORKSPACE_DIR/.vscode-server"

# Ensure npm global directory exists and has correct permissions
mkdir -p "$HOME/.npm-global"
chmod -R 755 "$HOME/.npm-global"

# Ensure .npmrc exists with correct configuration
if [ ! -f "$HOME/.npmrc" ]; then
  echo "prefix=$HOME/.npm-global" > "$HOME/.npmrc"
fi

# Install VSCode extensions if they don't exist
if [ ! -f "$WORKSPACE_DIR/.vscode-server/.extensions-installed" ]; then
  echo "Installing VSCode extensions..."
  WORKSPACE_DIR="$WORKSPACE_DIR" /app/install-extensions.sh
  touch "$WORKSPACE_DIR/.vscode-server/.extensions-installed"
fi

# Copy default settings if they don't exist
if [ ! -f "$WORKSPACE_DIR/.vscode-server/data/Machine/settings.json" ]; then
  echo "Copying default settings..."
  mkdir -p "$WORKSPACE_DIR/.vscode-server/data/Machine"
  cp /app/settings.json "$WORKSPACE_DIR/.vscode-server/data/Machine/settings.json"
fi

echo "Starting VSCode Server on $WORKSPACE_DIR..."

# Use the determined directory as the base path for the VS Code server
exec /app/openvscode-server/bin/openvscode-server \
  --host 0.0.0.0 \
  --port 7860 \
  --without-connection-token \
  "${@}" \
  --extensions-dir="$WORKSPACE_DIR/.vscode-server/extensions" \
  --user-data-dir="$WORKSPACE_DIR/.vscode-server/data" \
  --

#!/bin/bash

# This script installs a set of useful VSCode extensions
# It will be executed during container startup

# Set the extensions directory
EXTENSIONS_DIR="${WORKSPACE_DIR:-/data}/.vscode-server/extensions"
SERVER_BIN="/app/openvscode-server/bin/openvscode-server"

# Make sure the extensions directory exists
mkdir -p "$EXTENSIONS_DIR"

# Function to install an extension
install_extension() {
    local extension_id=$1
    
    echo "Installing extension: $extension_id"
    
    # Use the server's built-in extension installation mechanism
    $SERVER_BIN --install-extension "$extension_id" \
        --extensions-dir="$EXTENSIONS_DIR" \
        --user-data-dir="${WORKSPACE_DIR:-/data}/.vscode-server/data" \
        --skip-getting-started \
        --skip-release-notes \
        --disable-telemetry \
        --without-connection-token
    
    echo "Extension installed: $extension_id"
}

echo "Installing VSCode extensions..."

# List of extensions to install
# Format: install_extension "publisher.extension"

# Python extensions
install_extension "ms-python.python"
install_extension "ms-python.vscode-pylance"

# JavaScript/TypeScript extensions
install_extension "dbaeumer.vscode-eslint"
install_extension "esbenp.prettier-vscode"

# Git extensions
install_extension "eamodio.gitlens"

# Docker extensions
install_extension "ms-azuretools.vscode-docker"

# General utility extensions
install_extension "ritwickdey.liveserver"

# Markdown extensions
install_extension "yzhang.markdown-all-in-one"

# Theme extensions
install_extension "dracula-theme.theme-dracula"
install_extension "github.github-vscode-theme"

# AI coding assistance (if available)
install_extension "github.copilot" || echo "GitHub Copilot extension not available, skipping..."

echo "All extensions have been installed successfully!"
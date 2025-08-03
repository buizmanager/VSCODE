#!/bin/bash

# Default workspace directory
WORKSPACE_DIR="/data"

echo "Starting VSCode Server on $WORKSPACE_DIR..."

# Use the determined directory as the base path for the VS Code server
exec /app/openvscode-server/bin/openvscode-server --host 0.0.0.0 --port 7860 --without-connection-token "${@}" --extensions-dir "$WORKSPACE_DIR/.vscode-server/extensions" --user-data-dir "$WORKSPACE_DIR/.vscode-server/data" --
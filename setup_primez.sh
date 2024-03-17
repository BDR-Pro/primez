#!/bin/bash

# Setup Script for primez with Precompiled Binaries

BIN_NAME=""

# Check the environment and set the binary name
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "freebsd"* ]]; then
  BIN_NAME="prime_linux"
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
  BIN_NAME="prime.exe"
else
  echo "Unknown or unsupported operating system. Exiting."
  exit 1
fi

# Full path to the binary
EXECUTABLE_PATH=$(pwd)/$BIN_NAME

# Decide on a bin path. Prefer local bin if it exists.
BIN_PATH="/usr/local/bin"
if [ -d "$HOME/bin" ]; then
  BIN_PATH="$HOME/bin"
fi

# Ensure the binary exists
if [ ! -f "$EXECUTABLE_PATH" ]; then
  echo "Binary $BIN_NAME not found. Make sure you're in the right directory or check the binary's existence."
  exit 1
fi

# Determine the target path
TARGET_PATH="$BIN_PATH/primez"

# Check if there's a dangling symlink and remove it
if [ -L "$TARGET_PATH" ] && [ ! -e "$TARGET_PATH" ]; then
  echo "Removing dangling symlink at $TARGET_PATH"
  rm "$TARGET_PATH"
fi

# Always copy the binary to the target path
cp -f "$EXECUTABLE_PATH" "$TARGET_PATH"
echo "primez has been copied to $TARGET_PATH. You can now run 'primez' from anywhere."

# Ensure execute permissions
chmod +x "$TARGET_PATH"

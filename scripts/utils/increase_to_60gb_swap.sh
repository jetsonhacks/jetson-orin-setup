#!/bin/bash

# Setup a 60 GB swap file on Ubuntu, with fallback if fallocate fails

set -euo pipefail

SWAPFILE="/swapfile"
SWAPSIZE="62G"
FSTAB="/etc/fstab"

echo "🔄 Disabling current swap (if any)..."
sudo swapoff -a || echo "⚠️  No active swap to disable."

if [ -f "$SWAPFILE" ]; then
    echo "🗑️  Removing existing swap file at $SWAPFILE..."
    sudo rm -f "$SWAPFILE"
fi

echo "📝 Creating new swap file of size $SWAPSIZE..."

if command -v fallocate >/dev/null; then
    sudo fallocate -l "$SWAPSIZE" "$SWAPFILE" || echo "⚠️  fallocate failed."
fi

# Check that swap file was created and is non-zero
if [ ! -s "$SWAPFILE" ]; then
    echo "⚠️  fallocate failed or swapfile is empty, falling back to dd..."
    sudo dd if=/dev/zero of="$SWAPFILE" bs=1G count=60 status=progress
fi

echo "🔐 Setting file permissions to 600..."
sudo chmod 600 "$SWAPFILE"

echo "⚙️  Formatting swap file..."
sudo mkswap "$SWAPFILE"

echo "✅ Enabling swap..."
sudo swapon "$SWAPFILE"

if ! grep -q "^$SWAPFILE" "$FSTAB"; then
    echo "💾 Making swap permanent in $FSTAB..."
    echo "$SWAPFILE none swap sw 0 0" | sudo tee -a "$FSTAB" > /dev/null
fi

echo "📊 Swap setup complete. Current swap usage:"
swapon --show
free -h

exit 0


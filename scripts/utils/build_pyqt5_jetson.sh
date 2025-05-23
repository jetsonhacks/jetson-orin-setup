#!/bin/bash
set -e

# ==============================================================================
# Script: build_pyqt5_jetson.sh
# Description: Builds PyQt5 from source on Jetson AGX Orin (ARM64, JetPack 6.2+)
#              with QtWebEngine explicitly disabled to reduce memory usage.
# Author: Laurent Amplis
# ==============================================================================

# -------------------------------
# Configuration
# -------------------------------
PYQT_VERSION="5.15.10"
SIP_VERSION="6.8.0"
CACHE_DIR="$HOME/.cache/dfl_wheels"
mkdir -p "$CACHE_DIR"

# -------------------------------
# Install system dependencies
# -------------------------------
echo "📦 Installing required system packages..."
sudo apt-get update
sudo apt-get install -y \
    build-essential qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools \
    libqt5gui5 libqt5widgets5 libqt5core5a libqt5dbus5 libqt5network5 \
    libgl1-mesa-dev wget

# -------------------------------
# Install Python dependencies
# -------------------------------
echo "🐍 Installing required Python packages..."
python3 -m pip install --upgrade pip wheel setuptools packaging tomli pyqt-builder || true

# -------------------------------
# Download and build SIP
# -------------------------------
cd /tmp
echo "⬇️  Downloading SIP $SIP_VERSION..."
wget -q https://files.pythonhosted.org/packages/source/s/sip/sip-${SIP_VERSION}.tar.gz
tar -xf sip-${SIP_VERSION}.tar.gz
cd sip-${SIP_VERSION}

echo "⚙️  Installing SIP..."
python3 -m pip install . --force-reinstall

# -------------------------------
# Download and configure PyQt5
# -------------------------------
cd /tmp
echo "⬇️  Downloading PyQt5 $PYQT_VERSION..."
wget -q https://files.pythonhosted.org/packages/source/P/PyQt5/PyQt5-${PYQT_VERSION}.tar.gz
tar -xf PyQt5-${PYQT_VERSION}.tar.gz
cd PyQt5-${PYQT_VERSION}

echo "📝 Writing pyproject configuration..."
cat > pyproject.toml <<EOF
[project]
name = "PyQt5"
version = "${PYQT_VERSION}"

[build-system]
requires = ["sip >=6.8"]
build-backend = "sipbuild.api"
EOF

cat > pyproject.cfg <<EOF
[sip.project]
disable = QtWebEngine
EOF

# -------------------------------
# Build PyQt5 and generate wheel
# -------------------------------
echo "🏗️  Building PyQt5 (QtWebEngine disabled)..."
sip-install
make -j$(nproc)

echo "📦 Building PyQt5 wheel..."
python3 -m pip wheel . -w "$CACHE_DIR"

echo "✅ PyQt5 v$PYQT_VERSION successfully built and saved in: $CACHE_DIR"

# Jetson Orin Setup

Automate your NVIDIA Jetson Orin environment setup efficiently for JetPack 5.x and later.

## Overview

This repository provides scripts to quickly configure your Jetson Orin device with a minimal and efficient development environment. It automates essential software installations and system optimizations for seamless productivity.

## Supported Devices

* Jetson AGX Orin
* Jetson Orin NX
* Jetson Orin Nano Super
* Jetson Orin Nano

## Prerequisites

* JetPack 5.x or later (Ubuntu 20.04+ recommended)
* Internet connectivity

## Features

* Verifies JetPack compatibility (minimum JetPack 5.x)
* System updates
* Installation of essential development tools and utilities:

  * Chromium Browser
  * Visual Studio Code
  * Jetson Stats Monitoring
  * PyTorch optimized for Jetson
  * Cursor IDE
  * PyQt5 (custom optimized build without QtWebEngine)
* System optimizations:

  * Increases swap space to 60GB
* Reboot check and prompt

## Usage

Clone this repository and execute the main setup script:

```bash
git clone https://github.com/jetsonhacks/jetson-orin-setup.git
cd jetson-orin-setup
chmod +x setup_jetson.sh
./setup_jetson.sh
```

## Additional Utility Scripts (Located in `/scripts/utils/`)

These scripts are provided as optional utilities to further optimize and extend your Jetson Orin setup:

| Script                      | Description                                                                                                  |
| --------------------------- | ------------------------------------------------------------------------------------------------------------ |
| `build_pyqt5_jetson.sh`     | Builds PyQt5 from source optimized for Jetson Orin without QtWebEngine (significantly reduces memory usage). |
| `increase_to_60gb_swap.sh`  | Configures the system to use 60GB of swap space to support memory-intensive builds and operations.           |
| `install_cursor_ide.sh`     | Installs Cursor IDE, a modern development environment optimized for AI-assisted coding.                      |
| `install_pytorch_jetson.sh` | Installs PyTorch specifically compiled and optimized for Jetson platforms, leveraging CUDA acceleration.     |

### Running Utility Scripts

To execute a utility script, make it executable and run:

```bash
chmod +x scripts/utils/<script_name>.sh
./scripts/utils/<script_name>.sh
```

Replace `<script_name>` with the appropriate script file name.

## Contribution

We welcome community contributions. Please ensure your scripts are documented clearly, tested thoroughly, and follow best practices.

To contribute:

1. Fork this repository.
2. Add your scripts under the `/scripts/utils/` directory.
3. Submit a Pull Request with a clear description of your changes and benefits.

## Release Notes

### Initial Release - April 2025

* Verified and tested primarily on Jetson Orin Nano Super.
* Added foundational scripts for system setup and essential tool installations.

### Update - May 2025

* Added PyTorch Jetson-optimized build.
* Included Cursor IDE installation.
* Provided swap space optimization script.
* Added PyQt5 optimized build script.
* All scripts have been tested on Jetson Orin AGX 64gb

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

*Maintained by JetsonHacks Community and Contributors.*

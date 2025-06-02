#!/usr/bin/env bash

# The 'install.sh' entrypoint script is always executed as the root user.
#
# This script installs Deno CLI.
#
# Sources:
#   - https://deno.land/install.sh
#   - https://github.com/denoland/deno_install/blob/master/install.sh

# Exit on error
set -e

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            echo "Running apt-get update..."
            apt-get update -qq
        fi
        apt-get -qq install --no-install-recommends "$@"
        apt-get clean
    fi
}

# Set environment
export DEBIAN_FRONTEND=noninteractive

# Set variables with defaults
# See https://github.com/denoland/deno/releases
VERSION="${VERSION:-latest}"
# Install packages globally.
PACKAGES="${PACKAGES:-}"

echo "Activating feature 'deno'"

# Clean up old package lists
rm -rf /var/lib/apt/lists/*

# Install required dependencies
check_packages ca-certificates curl dirmngr gpg gpg-agent

# Normalize version tag format
case "${VERSION}" in
    latest) TAG="$(curl -s https://dl.deno.land/release-latest.txt)" ;;
    v*)     TAG="${VERSION}"                                         ;;
    *)      TAG="v${VERSION}"                                        ;;
esac

# Run installer as non-root user
# If we don't already have Deno installed, install it now.
if ! deno --version > /dev/null; then
    echo "Installing Deno ${TAG}..."
    su "${_REMOTE_USER}" -c "curl -fsSL https://deno.land/install.sh | sh -s -- --yes ${TAG}"
fi

INSTALL_ENV=DENO_INSTALL
INSTALL_DIR="${!INSTALL_ENV:-${_REMOTE_USER_HOME}/.deno}"
BIN_DIR="${INSTALL_DIR}/bin"
EXE="${BIN_DIR}/deno"

# Install global packages if specified
# See https://docs.deno.com/runtime/reference/cli/install/#global-installation
if [ "${#PACKAGES[@]}" -gt 0 ]; then
    echo "Installing global packages..."
    su "${_REMOTE_USER}" -c "$EXE install --global --allow-net --allow-read ${PACKAGES}"
fi

echo "Done!"

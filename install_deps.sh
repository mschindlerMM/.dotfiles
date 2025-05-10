#!/usr/bin/env bash

set -euo pipefail

log() {
  echo -e "\033[1;32m===> $1\033[0m"
}

warn() {
  echo -e "\033[1;33m⚠️  $1\033[0m"
}

# ---------------------------
# NVM
# ---------------------------
NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  source "$NVM_DIR/nvm.sh"
fi

if ! command -v nvm >/dev/null 2>&1; then
  log "NVM is missing. Installing..."
  PROFILE=/dev/null bash -c "curl -s -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash"
  source "$NVM_DIR/nvm.sh"
fi

if [ "$(nvm current)" == "none" ]; then
  log "No Node.js version installed. Installing Node.js 18..."
  nvm install 18
  nvm alias default 18
fi

# ---------------------------
# Homebrew (Linuxbrew)
# ---------------------------
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif ! command -v brew >/dev/null 2>&1; then
  log "Homebrew is missing. Installing..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  if command -v yum >/dev/null 2>&1; then
    log "Installing development tools via yum..."
    sudo yum -y groupinstall 'Development Tools'
  fi

  brew install gcc
fi

# ---------------------------
# thefuck
# ---------------------------
if ! command -v thefuck >/dev/null 2>&1; then
  log "Installing thefuck..."
  brew install thefuck
fi

# ---------------------------
# vcprompt
# ---------------------------
if ! command -v vcprompt >/dev/null 2>&1; then
  log "Installing vcprompt..."
  brew install vcprompt
fi

# ---------------------------
# ASDF
# ---------------------------
ASDF_DIR="$HOME/.asdf"
if [ -s "$ASDF_DIR/asdf.sh" ]; then
  . "$ASDF_DIR/asdf.sh"
fi

if ! command -v asdf >/dev/null 2>&1; then
  log "Installing ASDF..."
  git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch v0.14.0
  . "$ASDF_DIR/asdf.sh"
fi

# ---------------------------
# RVM
# ---------------------------
RVM_SCRIPT="$HOME/.rvm/scripts/rvm"
if [ -s "$RVM_SCRIPT" ]; then
  source "$RVM_SCRIPT"
fi

if ! command -v rvm >/dev/null 2>&1; then
  log "Installing RVM..."
  gpg --keyserver keyserver.ubuntu.com --recv-keys \
    409B6B1796C275462A1703113804BB82D39DC0E3 \
    7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
    || warn "GPG key fetch failed, but trying to proceed."

  \curl -sSL https://get.rvm.io | bash -s stable --ruby

  source "$RVM_SCRIPT"
fi

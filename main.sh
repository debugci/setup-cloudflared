#!/bin/bash
set -e

export GH_TOKEN=$GITHUB_TOKEN

if [[ $RUNNER_OS == Linux ]]; then
  if [[ $INPUT_CLOUDFLARED_VERSION == latest ]]; then
    sudo mkdir -p --mode=0755 /usr/share/keyrings
    curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
    echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared jammy main' | sudo tee /etc/apt/sources.list.d/cloudflared.list
    sudo apt-get update && sudo apt-get install cloudflared
  else
    gh release download -R cloudflare/cloudflared "$INPUT_CLOUDFLARED_VERSION" -p cloudflared-linux-amd64
    chmod +x cloudflared-linux-amd64
    sudo mv cloudflared-linux-amd64 /usr/local/bin/cloudflared
  fi
elif [[ $RUNNER_OS == Windows ]]; then
  if [[ $INPUT_CLOUDFLARED_VERSION == latest ]]; then
    gh release download -R cloudflare/cloudflared -p cloudflared-windows-amd64.msi
  else
    gh release download -R cloudflare/cloudflared "$INPUT_CLOUDFLARED_VERSION" -p cloudflared-windows-amd64.msi
  fi
  sudo ./cloudflared-windows-amd64.msi
elif [[ $RUNNER_OS == macOS ]]; then
  if [[ $INPUT_CLOUDFLARED_VERSION == latest ]]; then
    brew install cloudflare/cloudflare/cloudflared
  else
    gh release download -R cloudflare/cloudflared "$INPUT_CLOUDFLARED_VERSION" -p cloudflared-darwin-amd64.tgz
    tar -xzvf cloudflared-darwin-amd64.tgz
    sudo mv cloudflared /usr/local/bin/cloudflared
  fi
fi

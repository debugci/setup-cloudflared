#!/bin/bash
set -e

if [[ $RUNNER_OS == Linux ]]; then
  if [[ $INPUT_CLOUDFLARED_VERSION == latest ]]; then
    sudo mkdir -p --mode=0755 /usr/share/keyrings
    curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
    echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared jammy main' | sudo tee /etc/apt/sources.list.d/cloudflared.list
    sudo apt-get update && sudo apt-get install cloudflared
  else
    # gh release download -R cloudflare/cloudflared "v$INPUT_CLOUDFLARED_VERSION"
    # chmod +x cloudflared
    # sudo mv cloudflared /usr/local/bin/cloudflared
  fi
elif [[ $RUNNER_OS == Windows ]]; then
  # cmd.exe ""
elif [[ $RUNNER_OS == macOS ]]; then
  brew install cloudflare/cloudflare/cloudflared
fi

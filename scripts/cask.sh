#!/bin/sh

echo "==> 📜 Installing Homebrew Cask apps"

# General
brew install --cask gpg-suite-no-mail
brew install --cask jordanbaird-ice
brew install --cask monitorcontrol
brew install --cask notunes
brew install --cask qobuz
brew install --cask claude
brew install --cask chatgpt
brew install --cask ghostty
brew install --cask zoom
brew install --cask iina
brew install --cask kap
brew install --cask moom
brew install --cask font-monaspace
brew install --cask granola

# Development
brew install --cask gitify
brew install --cask firefox
brew install --cask tableplus
brew install --cask sourcetree
brew install --cask imageoptim
brew install --cask sublime-merge
brew install --cask google-chrome
brew install --cask google-chrome@canary
brew install --cask docker-desktop
brew install --cask google-cloud-sdk
brew install --cask github
brew install --cask lens
brew install --cask openvpn-connect
brew install --cask postman
brew install --cask yaak # postman replacement
brew install --cask zed

# App development
# brew install --cask zulu@17
# brew install --cask expo-orbit
# brew install --cask android-studio

# Personal use
brew install --cask 1password
brew install --cask 1password-cli
brew install --cask surfshark
brew install --cask hp-easy-start
brew install --cask obsidian

# NOTE: Install Raycast last so it enables extensions for other apps
brew install --cask raycast

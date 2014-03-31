#!/bin/bash

export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future

echo "Setting up Developer Tools CLI..."
sudo xcode-select --install
sudo java

echo "Installing Homebrew..."
#curl -fsSL https://raw.githubusercontent.com/DjedStudios/getting-started/master/setup.py | python
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

echo "Installing Cask..."
brew install phinze/cask/brew-cask

echo "Installing apps..."
brew cask install pycharm
brew cask install hipchat
brew cask install virtualbox
brew cask install vagrant
brew cask install pgadmin3
brew cask install github
brew cask install sourcetree

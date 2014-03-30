#!/bin/bash

export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future

echo "Installing Fabric..."
sudo easy_install pip
sudo pip install fabric
echo "Setting up Developer Tools CLI..."
sudo xcode-select --install
sudo java
echo "Beginning install of important software..."
curl -fsSL https://raw.githubusercontent.com/DjedStudios/getting-started/master/setup.py | python

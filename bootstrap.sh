#!/bin/bash

echo "Installing Fabric..."
sudo easy_install pip
sudo pip install fabric
echo "Beginning install of important software..."
curl -fsSL https://raw.githubusercontent.com/DjedStudios/getting-started/master/setup.py | python

#!/bin/bash

xcode-select --print-path
RETVAL=$?
if [ $RETVAL -ne 0 ]; then
    echo " * Setting up Developer Tools CLI..."
    xcode-select --install
fi

java -version

if [ ! -e /usr/local/bin/brew ]; then
    echo " * Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

echo " * Installing Cask..."
brew install phinze/cask/brew-cask

echo " * Installing apps..."
brew cask install github
brew cask install sourcetree
brew install node
brew cask install sublime-text
brew cask install google-chrome
brew cask install firefox
brew cask install sketch

if [ ! -e '/usr/local/bin/grunt' ]; then
    npm install -g grunt-cli
fi

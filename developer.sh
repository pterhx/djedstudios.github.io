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
brew cask install pycharm
brew cask install hipchat
brew cask install virtualbox
brew cask install vagrant
brew cask install pgadmin3
brew cask install github
brew cask install sourcetree
brew cask install iterm2
brew cask install sublime-text
brew cask install google-chrome
brew cask install firefox
brew install tmux
brew install node
brew install boot2docker

if [ ! -e '/usr/local/bin/grunt' ]; then
    sudo npm install -g grunt-cli
fi

echo "export DOCKER_HOST=tcp://localhost:4243" >> ~/.bashrc

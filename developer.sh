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

if [ ! -e "/usr/local/opt/brew-cask" ]; then
    echo " * Installing Cask..."
    brew install phinze/cask/brew-cask
fi

APPS_DIR="${HOME}/Applications"

echo " * Installing apps..."
if [ ! -e "${APPS_DIR}/PyCharm.app" ]; then
    brew cask install pycharm
fi

if [ ! -e "${APPS_DIR}/HipChat.app" ]; then
    brew cask install hipchat
fi

if [ ! -e "/usr/bin/VBoxManage" ]; then
    brew cask install virtualbox
fi

if [ ! -e "/usr/bin/vagrant" ]; then
    brew cask install vagrant
fi

if [ ! -e "${APPS_DIR}/pgAdmin3.app" ]; then
    brew cask install pgadmin3
fi

if [ ! -e "${APPS_DIR}/GitHub.app" ]; then
    brew cask install github
fi

if [ ! -e "${APPS_DIR}/SourceTree.app" ]; then
    brew cask install sourcetree
fi

if [ ! -e "${APPS_DIR}/iTerm.app" ]; then
    brew cask install iterm2
fi

if [ ! -e "${APPS_DIR}/Sublime Text 2.app" ]; then
    brew cask install sublime-text
fi

if [ ! -e "${APPS_DIR}/Google Chrome.app" ]; then
    brew cask install google-chrome
fi

if [ ! -e "${APPS_DIR}/Firefox.app" ]; then
    brew cask install firefox
fi

if [ ! -e "/usr/local/bin/tmux" ]; then
    brew install tmux
fi

if [ ! -e "/usr/local/bin/node" ]; then
    brew install node
fi

if [ ! -e "/usr/local/bin/docker" ]; then
    brew install boot2docker
fi

if [ ! -e '/usr/local/bin/grunt' ]; then
    sudo npm install -g grunt-cli
fi

touch ~/.bashrc

if [ `grep -c DOCKER_HOST ~/.bashrc` -eq 0 ]; then
    echo "export DOCKER_HOST=tcp://localhost:4243" >> ~/.bashrc
fi

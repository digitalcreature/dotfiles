#!/bin/bash
echo "Installing powerline..."
cd powerline-shell
install.py
cd ..
if [ -f ~/.bashrc ]; then
	echo "Backing up old .bashrc..."
	rm -f ~/.bashrc.bak
	mv ~/.bashrc ~/.bashrc.bak
fi
echo "Copying .bashrc..."
cp .bashrc ~/.bashrc
echo 'export DOTFILES_HOME="'$PWD'"' >> ~/.bashrc
echo 'source $DOTFILES_HOME/bootstrap' >> ~/.bashrc
echo "Installation complete!"

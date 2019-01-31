#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".vimrc"\
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;

		rsync /terminator/config ~/.config/terminator/config;

		source ~/.bash_profile;

}

function vimrcDoIt() {


	if [ ! -d ~/.vim_runtime ]
	then
		mkdir ~/.vim_runtime;
	fi

	cp -r vimrc/* ~/.vim_runtime;
	cp .vimrc ~/.vim_runtime/my_configs.vim;
	sh ~/.vim_runtime/install_awesome_vimrc.sh;

}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
	vimrcDoIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
		vimrcDoIt;
	fi;
fi;
unset doIt;

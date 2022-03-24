#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function fileSync (){
	rsync --exclude ".git/" \
		--exclude "terminator/"\
		--exclude "vimrc/"\
		--exclude ".vimrc"\
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;

	# Copy Terminator config file (somme times need to be manual enabled).
	mkdir -p ~/.config/terminator && rsync terminator/config ~/.config/terminator/config;


}

function vimrConfig() {


	if [ ! -d ~/.vim_runtime ]
	then
		mkdir ~/.vim_runtime;
	fi

	cp -r vimrc/* ~/.vim_runtime;
	cp .vimrc ~/.vim_runtime/my_configs.vim;
	sh ~/.vim_runtime/install_awesome_vimrc.sh;

}

function zshPluguinConfig() {
		# Only proceed if zsh is installed
		echo "Cheking for ZSH"
		if command -v zsh > /dev/null;
		then
				echo "Install oh-my-zzsh pluguins."
				git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
				git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;

		else
				echo "ZSH not detected. Skipping pluguin install...";
		fi
}

function doIt() {
		fileSync;
		vimrConfig;
		zshPluguinConfig	;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
		doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;

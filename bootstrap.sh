#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function fileSync (){
	rsync --exclude ".git/" \
		--exclude "terminator/"\
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;



}


function zshPluguinConfig() {
		# Only proceed if zsh is installed
		echo "Cheking for ZSH"
		if command -v zsh > /dev/null;
		then
				echo "Install oh-my-zzsh plugins."
				if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
								git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
				fi
				if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
				git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;
				fi
				if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z ]; then
				git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
				fi

		else
				echo "ZSH not detected. Skipping plugin install...";
		fi
}
function terminatorConfig(){
	# Copy Terminator config file (somme times need to be manual enabled).

	mkdir -p ~/.config/terminator && rsync terminator/config ~/.config/terminator/config;

	sudo cp ./terminator/terminator.png /usr/share/icons/hicolor/48x48/apps/;

	sudo sed -i "s/Icon=terminator/Icon=\/usr\/share\/icons\/hicolor\/48x48\/apps\/terminator.png/" /usr/share/applications/terminator.desktop;

}


function doIt() {
		fileSync;
		zshPluguinConfig;

		if which terminator > /dev/null 2>&1; then
	
		terminatorConfig;

		else

		echo "Terminator not installed..."
		
		fi

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


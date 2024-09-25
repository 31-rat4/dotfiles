#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
function fileSync (){
	exclusion=(
		--exclude ".git/" 
		--exclude "bootstrap.sh" 
		--exclude "backup.sh"
		--exclude "README.md" 
		--exclude "LICENSE-MIT.txt"
		)
	echo "running filesync...";
	rsync -av "$SCRIPT_DIR" "$HOME";
}
function zshPluguinConfig() {
		# Only proceed if zsh is installed
		echo "Cheking for ZSH"
		if command -v zsh > /dev/null;
		then
				plugin_folder=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins
				echo "Install oh-my-zzsh plugins.";
				if [ ! -d ${plugin_folder}/zsh-autosuggestions ]; then
								git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
				else
					echo "entering else ..."
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
	echo "running terminatorConfig..."

	sudo cp ./assets/terminator.png /usr/share/icons/hicolor/48x48/apps/;

	sudo sed -i "s/Icon=terminator/Icon=\/usr\/share\/icons\/hicolor\/48x48\/apps\/terminator.png/" /usr/share/applications/terminator.desktop;

# Add Shortcut
#gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Launch Terminator'
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'terminator'
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Ctrl><Alt>t'
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


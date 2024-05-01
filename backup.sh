#!/usr/bin/env bash
function config(){
		config_path="${HOME}/.config"
	list=(nvim terminator)
	for folder in ${list[@]}; do 
		rsync -r "${config_path}/${folder}" ".config/"
	done

}
function home(){
	config_path="${HOME}"
	list=(".vimrc" ".zshrc")
	for file_name in ${list[@]}; do 
		rsync "${config_path}/${file_name}" .
	done
}
function main(){
	config
	home
}
main


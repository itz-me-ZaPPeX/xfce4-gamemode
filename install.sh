#!/usr/bin/env bash

## VARIABLES
app_folder="$(cd "$(dirname "${0}")" && pwd)"
destination_folder="/opt/xfce4-gamemode"

## PRIVILEGIES CHECK
if [ ! "$EUID" = 0 ]
then
	echo "The installation script must be run with administrator privileges!"
	exit
fi

## INSTALLATION CONFIRMATION
read -p "Are you sure you want to continue the installation? [Y/n]: " question

case "$question" in
Y | y )
	echo
	echo "Copying the directory with the utility files to \"$destination_folder\"..."
	cp -r "$app_folder/src" "$destination_folder"
	echo
	echo "Adding the right to execute the utility..."
	chmod ugo+x "$destination_folder/xfce4-gamemode.sh"
	echo
	echo "Creating a symlink from \"$destination_folder/xfce4-gamemode.sh\" to \"/usr/bin/xfce4-gamemode\"..."
	ln -s "$destination_folder/xfce4-gamemode.sh" "/usr/bin/xfce4-gamemode"
	echo
	echo "The installation is complete! For help, please run \"xfce4-gamemode --help\". In case you need to remove it, run \"xfce4-gamemode --uninstall\"."
;;
N | n )
	echo "Installation canceled."
esac

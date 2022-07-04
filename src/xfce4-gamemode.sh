#!/usr/bin/env bash

## VARIABLES
# FILES AND FOLDERS WITH WHICH THE SCRIPT WORKS
config_folder="$HOME/.config/xfce4-gamemode"
init_config="$config_folder/init.conf"
custom_preset_config="$config_folder/custom-preset.conf"
xfce4_gamemode_data="$HOME/.local/share/xfce4-gamemode.data"
update_folder="$HOME/.cache/xfce4-gamemode-update"
# OUTPUT
gamemode_output_on="Gamemode is running. Preset in use -"
gamemode_output_off="Gamemode is stopped."
input_error="Input error! Use the \"help\" operand to view detailed usage information."
text_editor_question="Which text editor do you want to open the file with?: "
init_manage_output="Init-system service management"
cancel_output="Action canceled."
update_error_output="An error occurred while updating!"
invalid_parameter_output="Invalid parameter!"
# STOP APPS/SERVICES
stop_dpms='xset s off -dpms'
stop_compositing='xfwm4 --replace --compositor=off'
stop_xfce4_panel='xfce4-panel --quit'
stop_xfdesktop='xfdesktop --quit'
stop_nm_applet='killall nm-applet'
stop_blueman_applet='killall blueman-applet'
stop_xfce4_power_manager='killall xfce4-power-manager'
stop_light_locker='killall light-locker'
stop_xfce4_clipman='killall xfce4-clipman'
stop_xfce4_notifyd='killall xfce4-notifyd'
# LAUNCH APPS/SERVICES
start_dpms='xset s on dpms'
start_compositing='xfwm4 --replace --compositor=on'
start_xfce4_panel='xfce4-panel'
start_xfdesktop='xfdesktop'
start_nm_applet='nm-applet'
start_blueman_applet='blueman-applet'
start_xfce4_power_manager='xfce4-power-manager'
start_light_locker='light-locker'
start_xfce4_clipman='xfce4-clipman'
start_xfce4_notifyd='/usr/lib/xfce4/notifyd/xfce4-notifyd'
# OTHER
xfce4_gamemode_content="init_manage=false
preset=default
xfce4_gamemode_status=inactive"

## FUNCTIONS
# DELETE CONFIGURATION FILES
function reset_config(){
	if [ -d "$config_folder" ]
	then
		rm -rf "$config_folder"
		echo "Utility configuration files have been reset."
	else
		echo "Directory with the utility configuration files was not found."
	fi
}
# DELETE UTILITY DATA
function reset_data(){
	if [ -f "$xfce4_gamemode_data" ]
	then
		rm -rf "$xfce4_gamemode_data"
		echo "Utility data has been reset."
	else
		echo "Utility data file was found."
	fi
}
# UNINSTALL UTILITY
function remove(){
	if [ -d "/opt/xfce4-gamemode" ]
	then
		sudo rm -rf "/opt/xfce4-gamemode"
		sudo unlink "/usr/bin/xfce4-gamemode"
	else
		echo "Directory with utilities files not found."
	fi
}
# CHECK IF SPECIFIED TEXT EDITOR IS AVAILABLE
function text_editor_check(){
if [ ! -f "/usr/bin/$editor" ]
then
	echo "Specified text editor not found!"
	exit
fi
}
# PROHIBITION ON MAKING EDITS DURING GAME MODE
function xfce4_gamemode_security(){
	case "$xfce4_gamemode_status" in
	active )
		echo "Turn off xfce4-gamemode to make changes!"
		exit
	esac
}
# UPDATE
function update_func(){
	if [ -d "/opt/xfce4-gamemode" ]
	then
		echo "Uninstalling old version of utility..."
		sudo rm -rf "/opt/xfce4-gamemode"
		sudo unlink "/usr/bin/xfce4-gamemode"
	fi
	echo "Installing new version of utility..."
	mv "src" "/opt/xfce4-gamemode"
	chmod ugo+x "/opt/xfce4-gamemode/xfce4-gamemode.sh"
	ln -s "/opt/xfce4-gamemode/xfce4-gamemode.sh" "/usr/bin/xfce4-gamemode"
	echo "Update installed successfully!"
}

## PRE-RUN CHECKS
# PRIVILEGIES CHECK
if [ "$EUID" = 0 ]
then
	echo "This utility cannot work with superuser rights!"
	exit
fi
# CHECK DIRECTORY WITH CONFIGURATION FILES
if [ ! -d "$config_folder" ]
then
	mkdir -p "$config_folder"
fi
# CHECK AVAILABILITY OF CONFIGURATION FILE FOR SERVICE MANAGEMENT AT THE INIT-SYSTEM LEVEL
if [ ! -f "$init_config" ]
then
	cp "/opt/xfce4-gamemode/init.conf" "$init_config"
fi
# CHECK AVAILABILITY OF THE CONFIGURATION FILE OF THE CUSTOM MODE
if [ ! -f "$custom_preset_config" ]
then
	cp "/opt/xfce4-gamemode/custom-preset.conf" "$custom_preset_config"
fi

# CHECKING AVAILABILITY OF APPLICATION DATA
if [ ! -f "$xfce4_gamemode_data" ]
then
	echo "$xfce4_gamemode_content" > "$xfce4_gamemode_data"
fi

## USE CONFIGURATION FILES AND SETTINGS DATA
source "$init_config"
source "$custom_preset_config"
source "$xfce4_gamemode_data"

## CODE
case "$1" in
enable )
	if [ "$#" -gt 1 ]
	then
		echo "$input_error"
		exit
	fi
	case "$xfce4_gamemode_status" in
	active )
		echo "Utility is already working!"
		exit
	esac
	case "$init_manage" in
	true )
		pkexec bash -c "$(declare -f init-manage-ON); init-manage-ON"
	esac
	sed -i "s/xfce4_gamemode_status=.*/xfce4_gamemode_status=active/" "$xfce4_gamemode_data"
	case "$preset" in
	default )
		${stop_dpms} >> /dev/null 2>&1 &
		${stop_compositing} >> /dev/null 2>&1 &
		echo "$gamemode_output_on \"$preset\""
		exit
	;;
	performance )
		${stop_dpms} >> /dev/null 2>&1 &
		${stop_compositing} >> /dev/null 2>&1 & 
		${stop_xfdesktop} >> /dev/null 2>&1 &
		${stop_xfce4_clipman} >> /dev/null 2>&1 &
		echo "$gamemode_output_on \"$preset\""
		exit
	;;
	high-performance )
		${stop_dpms} >> /dev/null 2>&1 & 
		${stop_compositing} >> /dev/null 2>&1 &
		${stop_xfce4_panel} >> /dev/null 2>&1 &
		${stop_xfdesktop} >> /dev/null 2>&1 &
		${stop_nm_applet} >> /dev/null 2>&1 &
		${stop_blueman_applet} >> /dev/null 2>&1 &
		${stop_xfce4_power_manager} >> /dev/null 2>&1 &
		${stop_light_locker} >> /dev/null 2>&1 &
		${stop_xfce4_clipman} >> /dev/null 2>&1 &
		${stop_xfce4_notifyd} >> /dev/null 2>&1 &
		echo "$gamemode_output_on \"$preset\""
		exit
	;;
	custom-preset )
		custom-mode-ON
		echo "$gamemode_output_on \"$preset\""
		exit
	esac
;;
disable )
	if [ "$#" -gt 1 ]
	then
		echo "$input_error"
		exit
	fi
	case "$xfce4_gamemode_status" in
	inactive )
		echo "Utility is inactive!"
		exit
	esac
	case "$init_manage" in
	true )
		pkexec bash -c "$(declare -f init-manage-OFF); init-manage-OFF"
	esac
	sed -i "s/xfce4_gamemode_status=.*/xfce4_gamemode_status=inactive/" "$xfce4_gamemode_data"
	case "$preset" in
	default )
		${start_dpms} >> /dev/null 2>&1 &
		${start_compositing} >> /dev/null 2>&1 &
		echo "$gamemode_output_off"
		exit
	;;
	performance )
		${start_dpms} >> /dev/null 2>&1 &
		${start_compositing} >> /dev/null 2>&1 &
		${start_xfdesktop} >> /dev/null 2>&1 &
		${start_xfce4_clipman} >> /dev/null 2>&1 &
		echo "$gamemode_output_off"
		exit
	;;
	high-performance )
		${start_dpms} >> /dev/null 2>&1 &
		${start_compositing} >> /dev/null 2>&1 &
		${start_xfce4_panel} >> /dev/null 2>&1 &
		${start_xfdesktop} >> /dev/null 2>&1 &
		${start_nm_applet} >> /dev/null 2>&1 &
		${start_blueman_applet} >> /dev/null 2>&1 &
		${start_xfce4_power_manager} >> /dev/null 2>&1 &
		${start_light_locker} >> /dev/null 2>&1 &
		${start_xfce4_clipman} >> /dev/null 2>&1 &
		${start_xfce4_notifyd} >> /dev/null 2>&1 &
		echo "$gamemode_output_off"
		exit
	;;
	custom-preset )
		custom-mode-OFF
		echo "$gamemode_output_off"
		exit
	esac
;;
set )
	if [ "$#" -gt 3 ]
	then
		echo "$input_error"
		exit
	fi
	xfce4_gamemode_security
	case "$2" in
	--preset )
		case "$3" in
		default | performance | high-performance | custom-preset )
			sed -i "s/preset=.*/preset=$3/" "$xfce4_gamemode_data"
			echo "Preset changed to \"$3\"."
		;;
		* )
			echo "$input_error"
		esac
	;;
	--init-manage )
		case "$3" in
		true | false )
			sed -i "s/init_manage=.*/init_manage=$3/" "$xfce4_gamemode_data"
			case "$3" in
			true )
				echo "$init_manage_output allowed."
			;;
			false )
				echo "$init_manage_output disallowed."
			esac
		;;
		* )
			echo "$input_error"
		esac
	;;
	* )
		echo "$input_error"
	esac
;;
info )
	if [ "$#" -gt 1 ]
	then
		echo "$input_error"
		exit
	fi
	echo "Status: \"$xfce4_gamemode_status\""
	echo "Init-system service management: \"$init_manage\""
	echo "Preset used: \"$preset\""
	echo "Available presets: \"default\", \"performance\", \"high-performance\", \"custom-preset\""
	echo "Version: git-latest (04.07.2022)"
	echo "License: Apache 2.0"
	echo "Author: ZaPPeX"
	echo "Github: https://github.com/itz-me-ZaPPeX"
	echo "Russian warship, go fuck yourself!"
	echo
;;
edit )
	if [ "$#" -gt 2 ]
	then
		echo "$input_error"
		exit
	fi
	xfce4_gamemode_security
	case "$2" in
	--custom-preset )
		read -p "$text_editor_question" editor
		text_editor_check
		"$editor" "$custom_preset_config"
	;;
	--init-manage )
		read -p "$text_editor_question" editor
		text_editor_check
		"$editor" "$init_config"
	;;
	* )
		echo "$input_error"
	esac
;;
help | -h | --help )
	if [ "$#" -gt 1 ]
	then
		echo "$input_error"
		exit
	fi
	cat "/opt/xfce4-gamemode/help"
	echo
	echo
;;
keybind )
	if [ "$#" -gt 1 ]
	then
		echo "$input_error"
		exit
	fi
	case "$xfce4_gamemode_status" in
	inactive )
		xfce4-gamemode enable
	;;
	active )
		xfce4-gamemode disable
	esac
;;
reset )
	if [ "$#" -gt 2 ]
	then
		echo "$input_error"
		exit
	fi
	xfce4_gamemode_security
	case "$2" in
	--config | --data | --all )
		read -p "Do you really want to reset selected parameter? [Y/n]: " question
		case "$question" in
		Y | y )
			case "$2" in
			--config )
				reset_config
			;;
			--data )
				reset_data
			;;
			--all )
				reset_config
				reset_data
			esac
		;;
		N | n )
			echo "$cancel_output"
		;;
		* )
			echo "$invalid_parameter_output"
		esac
	;;
	* )
		echo "$input_error"
	esac
;;
uninstall )
	if [ "$#" -gt 1 ]
	then
		echo "$input_error"
		exit
	fi
	xfce4_gamemode_security
	read -p "Do you really want to uninstall this utility? [Y/n]: " question
	case "$question" in
	Y | y )
		sudo bash -c "$(declare -f remove); remove"
		if [ -d "/opt/xfce4-gamemode" ]
		then
			echo "You need superuser privileges to uninstall utility!"
			exit
		else
			echo "Utility files have been deleted."
		fi
		reset_config
		reset_data
	;;
	N | n )
		echo "$cancel_output"
	;;
	* )
		echo "$invalid_parameter_output"
	esac
;;
update )
	if [ "$#" -gt 1 ]
	then
		echo "$input_error"
		exit
	fi
	xfce4_gamemode_security
	read -p "Are you sure you want to update utility? [Y/n]: " question
	case "$question" in
	Y | y )
		echo "Creating a temporary directory for downloading update..."
		mkdir -p "$update_folder"
		if [ -d "$update_folder" ]
		then
			cd "$update_folder"
		else
			echo "$update_error_output"
			exit
		fi
		echo "Cloning repository..."
		git clone --quiet "https://github.com/itz-me-ZaPPeX/xfce4-gamemode.git"
		if [ -d "xfce4-gamemode" ]
		then
			cd "xfce4-gamemode"
		else
			echo "$update_error_output"
			exit
		fi
		if [ -d "src" ]
		then
			echo "Waiting for superuser rights..."
			sudo bash -c "$(declare -f update_func); update_func"
		else
			echo "$update_error_output"
			exit
		fi
		cd "$HOME"
		rm -rf "$update_folder"
	;;
	N | n )
		echo "$cancel_output"
	;;
	* )
		echo "$invalid_parameter_output"
	esac
;;
* )
	echo "$input_error"
esac

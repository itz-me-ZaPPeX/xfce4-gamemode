#!/usr/bin/env bash

## VARIABLES
# FILES WITH WHICH THE SCRIPT WORKS
config_folder=".config/xfce4-gamemode"
init_config="$config_folder/init.conf"
custom_preset_config="$config_folder/custom-preset.conf"
xfce4_gamemode_data=".local/share/xfce4-gamemode.data"
# OUTPUT
gamemode_output_on="XFCE4-GAMEMODE is running. The setting preset in use is - "
gamemode_output_off="XFCE4-GAMEMODE is stopped."
input_error="Input error. Use the \"--help/h\" operand to view detailed usage information."
xfce4_gamemode_content="init_manage=false
preset=default
xfce4_gamemode_status=inactive"
text_editor_question="Which text editor do you want to open the file with?: "
init_manage_output="Service management at the initialization system level"
cancel_output="The action is canceled."
# STOPPING APPLICATIONS/SERVICES
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
# LAUNCHING APPLICATIONS/SERVICES
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

## FUNCTIONS
# DELETING CONFIGURATION FILES
function reset_config(){
	if [ -d "$config_folder" ]
	then
		rm -rf "$config_folder"
		echo "The utility configuration files have been reset."
	else
		echo "The directory with the utility configuration files was not found."
	fi
}
# DELETING UTILITY DATA
function reset_data(){
	if [ -f "$xfce4_gamemode_data" ]
	then
		rm -rf "$xfce4_gamemode_data"
		echo "The utility data has been reset."
	else
		echo "No utility data file was found."
	fi
}
# UNINSTALLING THE UTILITY
function remove(){
	if [ -d "/opt/xfce4-gamemode" ]
	then
		sudo rm -rf "/opt/xfce4-gamemode"
		sudo unlink "/usr/bin/xfce4-gamemode"
		if [ -d "/opt/xfce4-gamemode" ]
		then
			echo "You need superuser privileges to uninstall the utility!"
			exit
		else
			echo "The utility files have been deleted."
		fi
	else
		echo "No directory with utility files was found."
	fi
}
# CHECK IF THE SPECIFIED TEXT EDITOR IS AVAILABLE
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
		echo "Turn off game mode to make changes!"
		exit
	esac
}

## PRE-RUN CHECKS
# PRIVILEGIES CHECK
if [ "$EUID" = 0 ]
then
	echo "This utility can only work on behalf of an unprivileged user!"
	exit
fi
# CHECK THE DIRECTORY WITH CONFIGURATION FILES
if [ ! -d "$config_folder" ]
then
	mkdir -p "$config_folder"
fi
# CHECKING THE AVAILABILITY OF THE CONFIGURATION FILE FOR SERVICE MANAGEMENT AT THE INITIALIZATION SYSTEM LEVEL
if [ ! -f "$init_config" ]
then
	cp "/opt/xfce4-gamemode/init.conf" "$init_config"
fi
# CHECK THE AVAILABILITY OF THE CONFIGURATION FILE OF THE CUSTOM MODE
if [ ! -f "$custom_preset_config" ]
then
	cp "/opt/xfce4-gamemode/custom-preset.conf" "$custom_preset_config"
fi

# CHECKING THE AVAILABILITY OF APPLICATION DATA
if [ ! -f "$xfce4_gamemode_data" ]
then
	echo "$xfce4_gamemode_content" > "$xfce4_gamemode_data"
fi

## USING CONFIGURATION FILES AND SETTINGS DATA
source "$init_config"
source "$custom_preset_config"
source "$xfce4_gamemode_data"

## CODE
case "$1" in
--enable | -e )
	if [ "$#" -gt 1 ]
	then
		echo "$input_error"
		exit
	fi
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
--disable | -d )
	if [ "$#" -gt 1 ]
	then
		echo "$input_error"
		exit
	fi
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
--set | -s )
	if [ "$#" -gt 3 ]
	then
		echo "$input_error"
		exit
	fi
	xfce4_gamemode_security
	case "$2" in
	preset )
		case "$3" in
		default | performance | high-performance | custom-preset )
			sed -i "s/preset=.*/preset=$3/" "$xfce4_gamemode_data"
			echo "Preset changed to \"$3\"."
		;;
		* )
			echo "$input_error"
		esac
	;;
	init-manage )
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
--info | -i )
	if [ "$#" -gt 1 ]
	then
		echo "$input_error"
		exit
	fi
	echo "Status: \"$xfce4_gamemode_status\""
	echo "Init-system service management: \"$init_manage\""
	echo "Preset used: \"$preset\""
	echo "Available presets: \"default\", \"performance\", \"high-performance\", \"custom-preset\""
	echo "Version: 1.0.0"
	echo "Author: ZaPPeX"
	echo "Github: https://github.com/itz-me-ZaPPeX"
	echo "Hello from Ukraine :)"
	echo "Russian warship, go fuck yourself!"
	echo
;;
--edit | -ed )
	if [ "$#" -gt 2 ]
	then
		echo "$input_error"
		exit
	fi
	xfce4_gamemode_security
	case "$2" in
	custom-preset )
		read -p "$text_editor_question" editor
		text_editor_check
		"$editor" "$custom_preset_config"
	;;
	init-manage )
		read -p "$text_editor_question" editor
		text_editor_check
		"$editor" "$init_config"
	;;
	* )
		echo "$input_error"
	esac
;;
--help | -h )
	if [ "$#" -gt 1 ]
	then
		echo "$input_error"
		exit
	fi
	cat "/opt/xfce4-gamemode/help"
	echo
;;
--keybind | -k )
	if [ "$#" -gt 1 ]
	then
		echo "$input_error"
		exit
	fi
	case "$xfce4_gamemode_status" in
	inactive )
		xfce4-gamemode --enable
	;;
	active )
		xfce4-gamemode --disable
	esac
;;
--reset | -r )
	if [ "$#" -gt 2 ]
	then
		echo "$input_error"
		exit
	fi
	xfce4_gamemode_security
	case "$2" in
	config | data | all )
		read -p "Do you really want to reset the selected parameter? [Y/n]: " question
		case "$question" in
		Y | y )
			case "$2" in
			config )
				reset_config
			;;
			data )
				reset_data
			;;
			all )
				reset_config
				reset_data
			esac
		;;
		N | n )
			echo "$cancel_output"
		;;
		* )
			echo "$input_error"
		esac
	;;
	* )
		echo "$input_error"
	esac
;;
--remove | -rm )
	if [ "$#" -gt 1 ]
	then
		echo "$input_error"
		exit
	fi
	xfce4_gamemode_security
	read -p "Do you really want to delete this utility? [Y/n]: " question
	case "$question" in
	Y | y )
		sudo bash -c "$(declare -f remove); remove"
		reset_config
		reset_data
	;;
	N | n )
		echo "$cancel_output"
	esac
;;
* )
	echo "$input_error"
esac

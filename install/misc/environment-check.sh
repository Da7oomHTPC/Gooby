#!/bin/bash

MENU="Check Environment"

[[ -s $CONFIGS/.config/seturl ]] && CHECKURL="$URL" || CHECKURL="Not set yet"
[[ -s $CONFIGS/.config/email ]] && CHECKEMAIL="$EMAIL" || CHECKEMAIL="Not set yet"

# Menu Options

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${CYAN}"
	MENUSTART
	echo " Timezone: ${CYAN}$TIMEZONE${STD}"
	echo " Your Domain: ${CYAN}$CHECKURL${STD}"
	echo " Your Email Address: ${CYAN}$CHECKEMAIL${STD}"
	echo " Your Server IP Address: ${CYAN}$PUBLICIP${STD}"
	echo ""
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${CYAN}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
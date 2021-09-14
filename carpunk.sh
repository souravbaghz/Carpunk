#!/bin/bash


#Project: CarPunk
#Coded By: souravbaghz

#+++++++++++++++++++++++++ WARNINGS ++++++++++++++++++++++++++ 
#EDUCATIONAL PURPOSE ONLY - DON'T USE ON UNAUTHORISED VEHICLES
#I AM NOT RESPONSIBLE FOR ANY BAD USE OF THIS TOOL 

#Colours
bold="\e[1m"
italic="\e[3m"
reset="\e[0m"
blink="\e[5m"
crayn="\e[36m"
yellow="\e[93m"
red="\e[31m"
black="\e[30m"
green="\e[92m"
redbg="\e[41m"
greenbg="\e[40m"


mkdir -p logs
#var
msg="          Hack the Car"
inc="1"

#=============================================
# PLEASE CHANGE THE INTERFACE AND LOG-NAME
i="vcan0"
log="carpunk"
#=============================================



banner(){
echo -e "${green}
|──────────────────────────────────────|         
   ▄▄·  ▄▄▄· ▄▄▄   ▄▄▄·▄• ▄▌ ▐ ▄ ▄ •▄  
  ▐█ ▌▪▐█ ▀█ ▀▄ █·▐█ ▄██▪██▌•█▌▐██▌▄▌▪ 
  ██ ▄▄▄█▀▀█ ▐▀▀▄  ██▀·█▌▐█▌▐█▐▐▌▐▀▀▄· 
  ▐███▌▐█ ▪▐▌▐█•█▌▐█▪·•▐█▄█▌██▐█▌▐█.█▌ 
  ·▀▀▀  ▀  ▀ .▀  ▀.▀    ▀▀▀ ▀▀ █▪·▀  ▀      
       ${greenbg}${green}<:coded by souravbaghz:>${reset}
   $msg                                          
$green|──────────────────────────────────────|$reset
        "
}


trap ctrl_c INT

ctrl_c(){
   echo
   echo "CTRL_C by user"
   menu
}

menu(){
clear
banner
echo -e " [1] UP the CAN Interface"
echo -e " [2] Down the CAN Interface"
echo -e " [3] Start the Basic Sniffing"
echo -e " [4] Record the CAN Packets"
echo -e " [5] Play the CAN Packets"

echo -e " [0] Exit"
read -p " [>] Choose: " option

if [[ $option = 1 || $option = 01 ]]
	then
        ip link set $i up
        msg="      Interface Is UP Now!"
        clear
		menu

	elif [[ $option = 2 || $option = 02 ]]
	   then
	    ip link set $i down
        msg="     Interface Is Down Now!"
        clear
		menu
        
    elif [[ $option = 3 || $option = 03 ]]
       then
         echo -e "${red}+${reset}------------------------------------${red}+${reset}"
         msg="       Happy Car Hacking"
         cansniffer $i -c
		 read -r -s -p $'Press ENTER to go menu.'
         clear
		 menu
		 
	elif [[ $option = 4 || $option = 04 ]]
       then
         echo -e "${red}+${reset}------------------------------------${red}+${reset}"
         msg=" Recorded & Stored as $log$inc.log"
         candump -L $i >logs/$log$inc.log
         inc=$((inc+1))
         echo " >"
		 read -r -s -p $'Press ENTER to go menu.'
		 menu

    elif [[ $option = 5 || $option = 05 ]]
       then
         echo -e "${red}+${reset}------------------------------------${red}+${reset}"
         msg="    Replay Attack Completed"
         read -p "[?]Enter log name: " logname
         canplayer -I logs/$logname
         clear
		 menu
		  	 
		 
	elif [[ $option = 0 || $option = 00 ]]
       then
         echo -e "[!]Exiting...${green}${reset}"
		 clear	 
         exit 1
         
        else
		echo "Invalid Option..."
		sleep 1
        msg="   Oops! It's incorrect option"
		clear
		menu
	fi	
}


menu


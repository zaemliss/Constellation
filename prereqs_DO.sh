#!/bin/bash
 
# Declare Variables
red='\033[1;31m'
grn='\033[1;32m'
yel='\033[1;33m'
blu='\033[1;36m'
pnk='\033[1;35m'
clr='\033[0m'

clear
echo
echo -e " ${yel}###############################################################${clr}"
echo -e " ${yel}#          ${grn}Constellation Dependency installer script${yel}          #${clr}"
echo -e " ${yel}###############################################################${clr}"
echo
echo -e " ${blu}Updating system ...${clr}"
echo -e " ${grn}sudo apt get update${clr}"
sudo apt update >/dev/null 2>&1
echo
echo
echo -e "${yel} Pre-requisites installed. ${clr}"

snap install jq
sudo apt install openjdk-8-jdk
sudo apt install haveged

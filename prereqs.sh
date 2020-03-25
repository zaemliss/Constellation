#!/bin/bash

# Declare Variables
red='\033[1;31m'
grn='\033[1;32m'
yel='\033[1;33m'
blu='\033[1;36m'
pnk='\033[1;35m'
clr='\033[0m'


function checkError() {
if [ $? -eq 0 ]; then
    return 0
else
    echo
    echo -e "This step caused an error! Aborting."
    exit
fi
}


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
echo -e " ${blu}Checking for dependencies ...${clr}"

#CHECK AND INSTALL JAVA
if type -p java >/dev/null 2>&1; then
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    _java="$JAVA_HOME/bin/java"
fi
if [[ "$_java" ]]; then
    javaver=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    if [[ "$javaver" > "1.8" ]]; then
        echo -e " ${grn}Java already at ${blu}$javaver${clr}"
        installJava=0
    else
        installJava=1
    fi
else
    installJava=1
fi

if [[ "$installJava" == "1" ]]; then
    echo -e " ${pnk}Installing latest Java version...${clr}"
    sudo apt install -y openjdk-8-jdk
fi

#CHECK AND INSTALL HAVEGED
if type -p haveged >/dev/null 2>&1; then
    installHaveged=1
fi
if [[ "$installHaveged" == "1" ]]; then
    echo -e " ${pnk}Installing latest version of Haveged...${clr}"
    sudo apt install haveged
fi

echo
echo -e "${yel} Pre-requisites installed. ${clr}"

#!/bin/bash

# Declare Variables
red='\033[1;31m'
grn='\033[1;32m'
yel='\033[1;33m'
blu='\033[1;36m'
pnk='\033[1;35m'
clr='\033[0m'

# Store external IP address
EXTERNAL_HOST_IP=$(curl -s https://api.ipify.org)

# Check and Create the Constellation home directory
DAGDIR=$HOME/constellation
if [ -d "$DAGDIR" ]; then
  echo -e "${red} WARNING ${yel}-${blu} the ${grn}$DAGDIR${blu} directory exists. The installation will copy the latest jar file to that directory. Do you want to continue?${yel}"
  read -e -p " Continue with installation? [Y/N] : " CHOICE
  if [[ ("$CHOICE" == "n" || "$CHOICE" == "N") ]]; then
    echo -e "${red} Installation aborted.${clr}"
    exit 1;
  fi
fi
echo -e "${clr}"

mkdir $DAGDIR >/dev/null 2>&1
cd $DAGDIR

clear
echo
echo -e " ${yel}###############################################################${clr}"
echo -e " ${yel}#          ${grn}Constellation Fast Node deplyoment script${yel}          #${clr}"
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
    sudo apt install -y openjdk-8-jdk >/dev/null 2>&1
fi

#Download 'dag' script to the user's bin directory
wget https://raw.githubusercontent.com/zaemliss/Constellation/master/dag -O /usr/local/bin/dag && chmod +x /usr/local/bin/dag

echo
echo -e " ${blu}Downloading latest Jar ...${clr}"
echo -e " ${blu}(this will take a few minutes)${clr}"

wget https://github.com/Constellation-Labs/constellation/releases/download/latest/constellation-assembly-latest.jar -O $DAGDIR/constellation-latest.jar >/dev/null 2>&1

read -e -p " Install Firewall? [Y/N] : " CHOICE
if [[ ("$CHOICE" == "y" || "$CHOICE" == "Y") ]]; then
  ufw --version >/dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    sudo apt install -y ufw
  fi
    sudo ufw default allow outgoing > /dev/null 2>&1
    sudo ufw default deny incoming > /dev/null 2>&1
    sudo ufw allow ssh/tcp > /dev/null 2>&1
    sudo ufw limit ssh/tcp > /dev/null 2>&1
    sudo ufw allow 9000/tcp > /dev/null 2>&1
    sudo ufw allow 9001/tcp > /dev/null 2>&1
    sudo ufw logging on > /dev/null 2>&1
    echo "y" | sudo ufw enable > /dev/null 2>&1
    echo
    echo -e " ${blu}Firewall installed and enabled.${clr}"
    echo
fi

read -e -p " Start the node? [Y/N] : " CHOICE
if [[ ("$CHOICE" == "n" || "$CHOICE" == "N") ]]; then
  echo -e "${yel} Installation complete... ${clr}"
  echo -e "${grn} You can type ${blu}dag ${grn}and press ${blu}[ENTER] for a list of command options.${grn}${clr}"
  exit 1;
fi

echo -e " ${grn}Deploying on ${blu}$EXTERNAL_HOST_IP ${grn}...${clr}"

bashexec="java -Xmx3G -jar $DAGDIR/constellation-latest.jar --ip $EXTERNAL_HOST_IP --port 9000"
screen -dmS dag $bashexec

echo -e "${grn} The node is started. You can access the output at any time by typing ${blu}dag status${grn} and pressing ${blu}[ENTER] ${grn}${clr}"
echo -e "${red} IMPORTANT: ${grn}once in the screen where you see the node output, exit by pressing ${blu}CTRL-A ${grn}then ${blu}CTRL-D"
echo -e "${grn} Do ${red}NOT ${grn}press ${blu}CTRL-C ${grn}unless you are trying to stop the node!"
echo
echo -e "${grn} You can also just type ${blu}dag ${grn}and press ${blu}[ENTER] for a list of command options${grn}${clr}"
echo -e "${grn} Furthermore, you can browse to your node web outpout by entering ${blu}http://$EXTERNAL_HOST_IP:9000 ${grn}in your web browser.${clr}"
echo
echo -e "${clr}"

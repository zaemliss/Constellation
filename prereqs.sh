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
echo -e " ${yel}#             ${grn}Constellation Node deployment script${yel}            #${clr}"
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


#INSTALL and SYMLINK PSSH
echo -e " ${grn}installing and linking pssh ...${clr}"
sudo apt install -y pssh >/dev/null 2>&1
echo "alias pssh=parallel-ssh" >> ~/.bashrc && . ~/.bashrc >/dev/null 2>&1

#INSTALL GSUTIL
gsversion=$(gsutil version 2>&1 | awk -F ':' '/version/ {print $2}')
if [[ "$gsversion" > "4.3" ]]; then
    echo -e " ${grn}GSUtil already at ${blu}$gsversion${clr}"
else
    echo -e " ${pnk}Installing latest GSUtil version...${clr}"
    wget https://storage.googleapis.com/pub/gsutil.tar.gz
    tar xfz gsutil.tar.gz -C $HOME
    export PATH=${PATH}:$HOME/gsutil
    exec -l $SHELL
fi

#INSTALL TERRAFORM
terraversion=$(terraform version | awk -F 'v' '{print $2}')
if [[ "$terraversion" > "0.12" ]]; then
    echo -e " ${grn}Terraform already at ${blu}$terraversion${clr}"
else
    echo -e " ${pnk}Installing latest Terraform version...${clr}"
    sudo apt-get install -y unzip >/dev/null 2>&1
    wget https://releases.hashicorp.com/terraform/0.12.9/terraform_0.12.9_linux_amd64.zip >/dev/null 2>&1
    unzip terraform_0.12.9_linux_amd64.zip >/dev/null 2>&1
    mv terraform /usr/local/bin >/dev/null 2>&1
fi

#INSTALL SCALA
    echo -e " ${pnk}Installing/updating latest Scala version...${clr}"
    sudo apt-get remove -y scala-library scala >/dev/null 2>&1
    sudo wget www.scala-lang.org/files/archive/scala-2.11.8.deb >/dev/null 2>&1
    sudo dpkg -i scala-2.11.8.deb >/dev/null 2>&1

#INSTALL SBT
dpkg -s sbta &> /dev/null
if [ $? -ne 0 ]; then
    echo -e " ${pnk}Installing/updating latest SBT version...${clr}"
    echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list >/dev/null 2>&1
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add >/dev/null 2>&1
    sudo apt-get update >/dev/null 2>&1
    sudo apt-get install sbt >/dev/null 2>&1
else
    echo -e " ${grn}SBT already installed${clr}"
fi
echo
echo -e " ${yel}Dependencies installation complete!${clr}"

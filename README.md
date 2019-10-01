# BUILD INSTRUCTIONS for the 3-node test:

## Dependencies
1. update/upgrade
```
sudo apt update
sudo apt upgrade
```
2. symlink pssh
```
echo "alias pssh=parallel-ssh" >> ~/.bashrc && . ~/.bashrc
```

3. install gsutil
```
wget https://storage.googleapis.com/pub/gsutil.tar.gz
tar xfz gsutil.tar.gz -C $HOME
export PATH=${PATH}:$HOME/gsutil
exec -l $SHELL
```

4. Install terraform
```bash
sudo apt-get install unzip
wget https://releases.hashicorp.com/terraform/0.12.9/terraform_0.12.9_linux_amd64.zip
unzip terraform_0.12.9_linux_amd64.zip
mv terraform /usr/local/bin
```
5. Reboot the VPS.

6. check for Java, if not found, install latest Java
```
sudo apt install openjdk-8-jdk
```

7. Install Scala
```
sudo apt-get remove scala-library scala
sudo wget www.scala-lang.org/files/archive/scala-2.11.8.deb
sudo dpkg -i scala-2.11.8.deb
```

8. Install SBT
```
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
sudo apt-get update
sudo apt-get install sbt
```

## Building
1. clone the repo: https://github.com/Constellation-Labs/constellation.git
```
cd ~
git clone https://github.com/Constellation-Labs/constellation.git
cd ~/constellation
```

2. build the binaries
```
./build.sh
```

3. answer the prompt for main class [1]

4. break out of the script (ctrl-c) 

## deploy the 3-node test
```
./deploy/compute/terraform/full-deploy.sh 3-node-test 3
```
note: change `3-node-test` with anything you want.


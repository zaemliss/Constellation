# Instructions:

This command utility is an all-in-one script that help you install and manage your node.

### 1. Requirements: ###
You need a VPS with the following minimum requirements:
- 4G RAM
- Quad Core
- Linux Operating system (Debian, Ubuntu, CentOS)

Also, if you have a p12 file you would like to use from a molly wallet, please make sure you copy it to the VPS prior to running the setup script. If you do not have one, the script will generate a p12 file for you.

***  WARNING *** It is assumed that the user you are running this with has root access and can write to /usr/local/bin as well as change file permissions.


### 2. Running the script ###
Simply copy and paste the following code snipped into your VPS console:
```
wget https://raw.githubusercontent.com/zaemliss/Constellation/master/dag -O /usr/local/bin/dag && chmod +x /usr/local/bin/dag && dag
```
___

And follow the instructions on the screen!

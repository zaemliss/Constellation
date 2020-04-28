# Instructions:

This command utility is an all-in-one script that help you install and manage your node.

### 1. Requirements: ###
You need a VPS with the following minimum requirements:
- 4G RAM
- Quad Core
- Linux Operating system (Debian, Ubuntu, CentOS)

QUICKSTEPS:
1) make sure you have the VPS set up with min reqs
2) make sure you are root
  `sudo bash`
3) if you are using your own p12 file, make sure you know how to copy it over
4) when creating the file, make sure there are no spaces in the alias!!! (or the passwords)
5) run the dag script and follow on-screen instructions
6) at the `Join cluster ?` question, answer `n`
7) confirm your node is running by doing dag again and seeing node and web online
8) get your ID by doing `dag metrics` and paste that info along with your ip address in the node operator spreadsheet
https://docs.google.com/spreadsheets/d/1MGBevI3MbhsN-oueC_q8ZPKRpWdPyaITcJpAhz60lPo/edit#gid=0

9) wait for the next release to be announced. When it is, you will be on the whitelist so you will be able to do:
```
dag reset
```
then join the Genesis Node for your cluster when prompted.

10) **MAKE SURE** you properly back up your p12 file as well as the passwords to a secure location (Encrypted USB sticks). If you lose this, you're done. No more coins.


Also, if you have a p12 file you would like to use from a molly wallet, please make sure you copy it to the VPS prior to running the setup script. If you do not have one, the script will generate a p12 file for you.

***  WARNING *** It is assumed that the user you are running this with has root access and can write to /usr/local/bin as well as change file permissions.


### 2. Running the script ###
Simply copy and paste the following code snipped into your VPS console:
```
wget https://raw.githubusercontent.com/zaemliss/Constellation/master/dag -O /usr/local/bin/dag && chmod +x /usr/local/bin/dag && dag
```
___

And follow the instructions on the screen!

___
# For debugging ONLY #
This will overwrite the default logback.xml so that the org.constellation logging level is set to `debug` instead of `warn`.
```
wget https://raw.githubusercontent.com/zaemliss/Constellation/master/logback.xml -O ~/constellation/logback.xml
```
 

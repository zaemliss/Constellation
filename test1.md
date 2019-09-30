## TEST : dag launch script using default (1st) IP
```
#!/bin/bash
IP_LIST=$(ifconfig | grep "inet " | awk {'print $2'} | grep -vE '127.0.0|192.168|172.16|10.0.0' | tr -d 'inet addr:')
IPs=(${IP_LIST[@]})

EXTERNAL_HOST_IP=${IPs[0]}
echo Deploying on $EXTERNAL_HOST_IP ...

bashexec="java -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9010 -Dcom.sun.management.jmxremote.rmi.port=9011 -Dcom.sun.manage$

echo $bashexec

screen -dmS dag $bashexec

```

1. download the latest binaries from the repo
2. place this script in an executable file named exec.sh and chmod +x
3. run the file with the binary as a command line argument:
```
./exec.sh constellation-assembly-1.0.1.jar
```

To see the output, simply do
```
screen -dr dag
```
to exit the output do CTRL-A then CTRL-D

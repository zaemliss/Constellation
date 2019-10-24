# Fast Node Installation Instructions - Constellation Node
1. Make sure your machine (or VPS) has the minimum requirements:
```
4 Core CPU
4gb RAM
Linux (Ubuntu, Debian, etc...)
```
*** NOTE: if you have an external and internal IP, make sure you have forwarding set to ON when deploying your instance ***
ref: <https://cloud.google.com/vpc/docs/using-routes#canipforward>

2. ssh into your linux server and paste the following command:
```bash
cd ~ && wget https://raw.githubusercontent.com/zaemliss/Constellation/master/fast-deploy.sh -O ./fast-deploy.sh && chmod +x ./fast-deploy.sh && ./fast-deploy.sh
```

3. once the installation is finished, type `dag` and press enter to see the status of your node. The top of the information page should say:
```
 Web Status : online
 Node Status: online
```
If either of those statuses are offline, wait 30 seconds and try the `dag` command again. Once the status is set to `online`, you can navigate on your computer's browser to the web page address given in the status information:
![DAG1](https://i.imgur.com/4WciL2a.png)

your Node State should be in `PendingDownload`

4. Next, join a cluster by typing `dag join ip_address_of_the_node`
ex.:
```
dag join 86.23.86.134
```

you should see the browser page status change to `DownloadInProgress` and eventually `Ready`

That's the end of the installation! Congratulations, your node is up and operational.
If you have any issues, please open an issue ticket here: https://github.com/zaemliss/Constellation/issues

________________________________

## FAST NODE 1-LINER INSTALL SCRIPT
paste the following in a CLI (terminal screen)
```
cd ~ && wget https://raw.githubusercontent.com/zaemliss/Constellation/master/fast-deploy.sh -O ./fast-deploy.sh && chmod +x ./fast-deploy.sh && ./fast-deploy.sh
```
________________________________
## `dag` COMMAND LINE UTILITY
paste the following in a CLI (terminal screen)
### Note that this is automatically downloaded and updated with the fast-installer script
```
wget https://raw.githubusercontent.com/zaemliss/Constellation/master/dag -O /usr/local/bin/dag && chmod +x /usr/local/bin/dag
```
________________________________
## FILEBEAT INSTALLATION SCRIPT
paste the following in a CLI (terminal screen)
```
wget https://raw.githubusercontent.com/zaemliss/Constellation/master/install-filebeat -O ./install-filebeat && chmod +x ./install-filebeat && ./install-filebeat
```

# Tpages Dockers Deployment (TDD)
<img src="../_static/tp-dockers-logo.jpg" width="500" height="110" alt="Script_Options"/>

-----------------------
## Table of Contents

- [**Introduction**](#introduction)
    - [***Ports Mapping***](#ports-mapping)
    - [***Directory Mounting***](#directory-mounting)
- [**Architecuture**](#architecture)
    - [***Layout***](#layout)
    - [***Images***](#images)
    - [***Default Services***](#default-services)
    - [***VirtualBox Port Forwarding***](#virtualbox-port-forwarding)
    - [***Running Containers***](#running-containers)
- [**Make Steps**](#make-steps)
    - [***Required: build images***](#required-build-images)
    - [***Required: start container***](#required-start-container)
    - [***Optional: state container***](#optional-state-container)
    - [***Optional: interact with container***](#optional-interact-with-container)
    - [***Optional: remove container***](#optional-remove-container)
- [**Special Notes**](#special-notes)
    - [***Upgrade gitlab-ce***](#upgrade-gitlab-ce)
    - [***Restore gitlab-ce***](#restore-gitlab-ce)
- [**TODO**](#todo)


## Introduction
[Docker][1]  is an open-source project that automates the deployment of applications inside software containers. Base on docker's lightweight, handy, quick deployment characteristic, we take advantages of its pros to automate our development, operation and maintenance, and also CI procedures.

Our docker deployment is made on MAC Pro (192.168.3.17), so the following doc will only discuss the topics pertained to the OSX operation system. Docker can be installed through downloading [docker toolbox][2]. No detailed steps will be covered in this doc. The docker on OSX are a little different from the one on Ubuntu or CentOS. You should always remember that there is a docker-machine (boot2docker) between the docker host (OSX) and your personalized docker client (images).

<div align="center" >
<img src="../_static/mac-docker-host.png"  alt="Script_Options"/>
</div>
<div align="center"> <p><b>Fig.1 OSX Docker Architecture</b></p> </div>

Seen from the figure above, the docker daemon in OSX is running inside a Linux virtual machine provided by Boot2Docker. Docker host address is the address of the Linux VM. When you start the boot2docker (using docker-machine command) process, the VM is assigned an IP address. Under boot2docker ports on a container map to ports on the VM.  Based on this concept, two things should be cautious at, ports mapping and directory mounting.

### Ports Mapping
On Ubuntu or other Linux Distribution,  the ports mapping of containers  is quite simple, adding -p option in docker run command or adding  "ports" directives in docker-compose config file, however, it is not such direct in Mac OSX. Besides adding -p option when you start a docker container or using "ports" in docker-compose, you should make another port mapping process in VirtualBox. Click the “settings” of VirtualBox, open the "Network" -->"Port Forwarding" panel, add the ports you want to map from the docker-machine (boot2docker) to the OSX. The two mapping steps can be shown like following.

```
OSX-Ports <------------------> Docker-Machine Ports <---------------------> Docker Container Ports
|------through virtualbox panel--------|-----through -p option or "ports" in docker-compose----|
```

### Directory Mounting
Besides ports mapping bothering feature of OSX, directory mounting is another trick when you would like to mount a directory other than user's home into docker container. In default, virtualBox automatically mount current user's home directory into the virtual machine. If you want to mount other places into the docker for usage of containers, more steps are needed to realize your task.

First, ssh into your docker-machine and make a mount point for mouting the host directory.
```bash
docker-machine ssh deploy
sudo mkidr -p /tpages
```
Second, share the folder to VirtualBox. You can click "settings" in VirtualBox and add "/tpages" in "sharing Folders" section, or you can type the following command to do the step.
```bash
vboxmanage sharedfolder add deploy --name tpages --hostpath /tpages/ --transient
```
Effect of above steps can be checked like the following picture.
<div align="center" >
<img src="../_static/tp-dockers-shared-folders.png" width="800" height="500"   alt="Script_Options"/>
</div>
<div align="center"> <p><b>Fig.2 Shared Folders Settings</b></p> </div>

Third, ssh into the docker-machine again and mount the folder we just shared.
```bash
docker-machine ssh deploy
sudo mount -t vboxsf -o uid=555,gid=555 tpages /tpages/
```

***Notice:***
- Redo the above three steps every time restarting the virtual machine
- Apply the above steps to each virtual machine (docker-machine) that you would like to mount specified folders
- In the third step that de facto mounts the directory, always use uid and gid that have not been taken by the virtual machine (docker-machine), actually 555 is really fine in our cases.


## Architecture

### Layout
<div  align="center">    
<img src="../_static/tpages-docker-deployment.png" alt="Script_Options" />
</div>
<div align="center"> <p><b>Fig.3 Tpages Dockers Deployment Layout</b></p> </div>

Our docker deployment architecture is seperated into five layers, with each related to our development, ci, or operation and maintenance functionalities.

-  **Physical Machine Layer**: OSX operation system with docker toolbox and virtualbox installed.
-  **Docker Machine Layer**: Boot2Docker image, which runs as virtual machine in virtualbox.
-  **Base Docker Image Layer**: Base docker images inherited from centos and ubuntu officials for building further application images.
-  **Application Docker Image Layer**: Docker images that are strongly related to our daily work, including development, version control, and operation and maintenance.
-  **Docker Container Layer**: Actually running environment (container).

***Important:*** You should always consider how many containers you may going to run in each docker-machine, and how much all running containers would consume hardwares resource of the docker-machine, including cpu, memory, and also disk space, before beginning to build docker images and launch docker containers.

Based on our schedule, we deploy two docker-machines (deploy and default) to leverage the load of all going-to-run containers in docker machine. And also we place the docker-machines image and its disk.vmdk into the removable device '/dev/disk4' mounted in '/tpages' folder to save the precious disk space of Mac Pro. Details hardware context of each docker machine is depicted as following.

| Docker Machine | CPUs     |   Memory |  Disk Space  |Shared Folders |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| tp-ubuntu      | 2       |  3GB|  Max 200GB      | /Users; /tpages|
| tp-centos     | 2       |  3GB|    Max 200GB    | /Users; /tpages|
<div align="center"> <p><b>Tab.1 Docker Machine Hardware Construction</b></p> </div>


### Images
The following table defined images details (os, version, size, inheritance relationship) we built on two main docker-machines, including tp-centos and tp-ubuntu.

| Docker-Machine     | Images     | Version | OS| Inherited| Size| Notes|
| :------------- | :------------- | :------------- | :------------- |:------------- | :----------- | :------------- |
| tp-centos       | centos      | 7     | CentOS 7    |   ---  |196.8 MB | CentOS 7 official docker image. |
|                    | tpages/centos-base      | v1.0.0   | CentOS 7  | centos:7  |  196.8 MB | CentOS base image with nginx, dnsmasq, supervisor, and openssh-server installed. |
|                    | tpages/dev-php53     | v1.0.0     | CentOS 7 |tpages/centos-base:v1.0.0   | 1.229 GB | Development image inherited from tpages/centos-base:v1.0.0 with  php-5.3.3 installed additionally. |
|                    | tpages/dev-php56     | v1.0.0     | CentOS 7 |tpages/centos-base:v1.0.0   | 821.8 MB | Development image inherited from tpages/centos-base:v1.0.0 with  php-5.6.23 installed additionally. |
|                    | tpages/operations     | v1.0.0     | CentOS 7 |tpages/dev-php56:v1.0.0   | 1.205 GB | Operation and maintenance image inherited from tpages/dev-php56:v1.0.0 with  awstats, ganglia, and nagios installed additionally. |
| tp-ubuntu       | ubuntu      | 14.04     | Ubuntu 14.04    |   ---  |196.6 MB | Ubuntu 14.04  official docker image. |
|                   | tpages/ubuntu-base      | v1.0.0     | Ubuntu 14.04    |  ubuntu:14.04  |424.4 MB | Ubuntu base image with dnsmasq, supervisor, and openssh-server installed. |
|                   | tpages/gitlab-ce      | v1.0.0     | Ubuntu 14.04    |  tpages/ubuntu-base:v1.0.0 |1.25 GB | Tpages VCS (version control system) docker image with gitlab-ce installed. |
|                   | tpages/satis-sinopia      | v1.0.0     | Ubuntu 14.04    |  tpages/ubuntu-base:v1.0.0  |724.6 MB | Tpages Private npm and composer repo image with sinopia and satis installed. |
<div align="center"> <p><b>Tab.2 Tpages Dockers Images Outline</b></p> </div>


### Default Services
The table below describe default running service on each container, which is defined in each docker-compose.yml file in corresponding docker image directory.

| Image     | Service (Container)   |  Ports Mapping   |   Volumes Mapping|
| :------------- | :------------- |:------------- |:------------- |
| tpages/centos-base:v1.0.0      | dnsmasq      |   622:22(ssh), 653:53(dns) |   -----|
| tpages/dev-php53:v1.0.0| dev-php53      |   624:22(ssh), 655:53(dns), 8010:80(http) |   /tpages/Dockers/tpages-dev-php53/www:/www|
| tpages/dev-php56:v1.0.0| dev-php56      |   625:22(ssh), 656:53(dns), 8011:80(http) |   /tpages/Dockers/tpages-dev-php56/www:/www|
| tpages/operations:v1.0.0| operations      |   626:22(ssh), 657:53(dns), 8004:8004(awstats-http), 8005:8005(nagios-http), 8006:8006(ganglia-http) |   /tpages/Dockers/volumes/operations/awstats-7.4:/usr/local/awstats-7.4; /tpages/Dockers/volumes/operations/ganglia-3.7.2:/usr/local/ganglia-3.7.2; /tpages/Dockers/volumes/operations/nagios-4.1.1:/usr/local/nagios-4.1.1; /tpages/Dockers/volumes/operations/logs:/usr/local/logs|
| tpages/ubuntu-base:v1.0.0| dnsmasq     |   623:22(ssh), 654:53(dns) |   ------|
| tpages/gitlab-ce:v1.0.0| gitlab-ce     |  627:22(ssh), 658:53(dns), 8001:8001(gitlab-http) |  /tpages/Dockers/tpages-gitlab-ce/assets:/etc/gitlab; /tpages/Dockers/gitlab-ce-backup:/backup|
| tpages/satis-sinopia:v1.0.0| satis-sinopia     | 628:22(ssh), 659:53(dns), 8002:8002(satis-http), 8003:8003(sinopia-http), 3333:3333(satis-build) |   /tpages/Dockers/tpages-satis-sinopia/assets/satis_conf:/app/satis_conf; /tpages/Dockers/tpages-satis-sinopia/assets/sinopia:/app/sinopia|
<div align="center"> <p><b>Tab.3 Tpages Docker Comose Default Running Services</b></p> </div>

### VirtualBox Port Forwarding
The following assigns all ports and their mapping relationship used in our docker containers environment

| Docker-Machine     | Name     | Protocol | Host IP | Host Port | Guest IP | Guest Port|Notes|
| :----- | :-------- |:------ |:------ |:------ |:------ |:------ |:------ |
| tp-centos    | awstats-http    | TCP | ---| 8004 | ---| 8004| Awstats web port in container operations.|
|                 | nagios-http    | TCP | ---| 8005 | --- | 8005| Nagios web port  in container operations.|
|                 | ganglia-http    | TCP | ---| 8006 | ---| 8006|Ganglia web port  in container operations. |
|                 | ssh    | TCP | 127.0.0.1| 54204 | ---| 22| Docker-machine default (boot2docker)  ssh port. |
|                 | dnsmasq-ssh    | TCP | ---| 9622 | ---| 622| Container dnsmasq ssh port. |
|                 | dnsmasq-dns    | TCP | ---| 9653 | ---| 653| Container dnsmasq dns tcp port. |
|                 | dev-php53-ssh    | TCP | ---| 9624 | ---| 624| Container dev-php53 ssh port. |
|                 | dev-php53-dns    | TCP | ---| 9655 | ---| 655| Container dev-php53 dns tcp port. |
|                 | dev-php53-http    | TCP | ---| 8010 | ---| 8010| Container dev-php53 http port. |
|                 | dev-php56-ssh    | TCP | ---| 9625 | ---| 625| Container dev-php56 ssh port. |
|                 | dev-php56-dns    | TCP | ---| 9656 | ---| 656| Container dev-php56 dns tcp port. |
|                 | dev-php56-http    | TCP | ---| 8011 | ---| 8011| Container dev-php56 http port. |
|                 | operations-ssh    | TCP | ---| 9626 | ---| 626| Container operations  ssh port. |
|                 | operations-dns    | TCP | ---| 9657 | ---| 657| Container operations  dns tcp port. |
|  tp-ubuntu  | dnsmasq-ssh   | TCP | ---| 9623 | ---| 623| Container dnsmasq ssh port. |
|                 | dnsmasq-dns  | TCP | ---| 9654 | ---| 654| Container dnsmasq dns tcp port. |
|                 | gitlab-ce-ssh  | TCP | ---|9627 | ---| 627| Container gitlab-ce  ssh port. |
|                 | gitlab-ce-dns  | TCP | ---| 9658 | ---| 658| Container gitlab-ce  dns tcp port. |
|                 | gitlab-ce-http  | TCP | ---| 8001 | ---| 8001| GitLab-ce web port in container gitlab-ce.|
|                 | satis-http  | TCP | ---| 8002 | ---| 8002| Satis web port in container satis-sinopia.|
|                 | sinopia-http  | TCP | ---| 8003 | ---| 8003| sinopia web port in container satis-sinopia.|
|                 | satis-build  | TCP | ---| 3333 | ---| 3333| Satis build port in container satis-sinopia. |
|                 | satic-sinopia-ssh  | TCP | ---| 9628 | ---| 628| Container satis-sinopia ssh port. |
|                 | satic-sinopia-dns  | TCP | ---| 9659 | ---| 659| Container satis-sinopia  ssh port. |
|                 | tp-ubuntu-ssh  | TCP | 127.0.0.1| 50933 | ---| 22| Docker-machine deploy (boot2docker)  ssh port.  |
<div align="center"> <p><b>Tab.4 Tpages Ports Forwarding in Docker-Machines</b></p> </div>

### Running Containers
| Docker-Machine    | Docker Image     |  Container| Ports Mapping| Volumes Mapping|
| :------------- | :------------- |:------------- |:------------- |:------------- |
| tp-centos      | tpages/operations:v1.0.0       |operations| 626:22(ssh), 657:53(dns), 8004:8004(awstats-http), 8005:8005(nagios-http), 8006:8006(ganglia-http),| /tpages/Dockers/volumes/operations/awstats-7.4:/usr/local/awstats-7.4; /tpages/Dockers/volumes/operations/ganglia-3.7.2:/usr/local/ganglia-3.7.2; /tpages/Dockers/volumes/operations/nagios-4.1.1:/usr/local/nagios-4.1.1; /tpages/Dockers/volumes/operations/logs:/usr/local/logs|
| tp-ubuntu     | tpages/gitlab-ce:v1.0.0       |gitlab-ce|  627:22(ssh), 658:53(dns), 8001:8001(gitlab-http),| /tpages/Dockers/tpages-gitlab-ce/assets:/etc/gitlab; /tpages/Dockers/gitlab-ce-backup:/backup|
|                  | tpages/satis-sinopia:v1.0.0       |satis-sinopia| 628:22(ssh), 659:53(dns), 8002:8002(satis-http), 8003:8003(sinopia-http), 3333:3333(satis-build)| /tpages/Dockers/tpages-satis-sinopia/assets/satis_conf:/app/satis_conf; /tpages/Dockers/tpages-satis-sinopia/assets/sinopia:/app/sinopia|
<div align="center"> <p><b>Tab.5 Tpages Running Containers in Production</b></p> </div>

## Make Steps

In this project, GNU Make is used to manage docker images and containers.  Nine tasks are included in the Makefile located in root of the project.

- test: task that test whether or not docker image directories are existed
- build: build the docker image defined in the Dockerfile of the docker image directory
- up: bring up a container defined in docker-compose.yml of the docker image directory  
- start: same as up
- stop: stop a container defined in docker-compose.yml of the docker image directory
- restart: restart the container that already started  defined in docker-compose.yml of the docker image directory
-  state: list states of the running container  defined in docker-compose.yml of the docker image directory
- remove: remove the running container  defined in docker-compose.yml of the docker image directory
- bash: interactively run bash with the running container defined in docker-compose.yml fo the docker image directory

To build and run the containers, please follow the following commands.

### Required: build images
 Always build images before running a container. The inheritance of all images are depicted below, please follow the order on building the images,
 ```
 centos7 -----> tpages/centos-base   -----> tpages/dev-php53
 centos7 -----> tpages/centos-base   ------> tpages/dev-php56  -----> tpages/operations
 ubuntu14.04 ------> tpages/ubuntu-base  -------> tpages/gitlab-ce
 ubuntu14.04 ------> tpages/ubuntu-base -------> tpages/saits-sinopia
 ```
with the following command:
```bash
make build target=tpages/centos-base
```
***Notice:*** Please build ubuntu based images in tp-ubuntu docker-machine, and centos-based images in tp-centos docker-machine. Well-built images should be looked like this.

<div align="center" >
<img src="../_static/tp-docker-centos-image.png"  alt="Script_Options"/>
</div>
<p/>
<div align="center">
<img src="../_static/tp-docker-ubuntu-image.png"  alt="Script_Options"/>
</div>
<div align="center"> <p><b>Fig.4 TpagesDocker Images</b></p> </div>

### Required: start container
Once all iamges are built, you can start a container with following command. Recently, we actually running three containers, including operations, gitlab-ce, and satis-sinopia.  But each image has its own default container (service), you can check the service in Tab. 2.
```bash
make up target=tpages-operations
```
### Optional: state container
You can list states of a container with the following command.
```bash
make state target=tpages-operations
```
### Optional: interact with container
You can interact with a container with the following command, then you can get a bash,  also you can ssh into a container with username root whose password is "123456" and port specified in Tab. 3.
```bash
make bash target=tpages-operations
# or
ssh root@192.168.3.17 -p 9626
```

### Optional: remove container
You can stop and remove a container with the command below.
```bash
make remove target=tpages-operations
```

## Special Notes

### Upgrade gitlab-ce
Since it is really dammed slow when upgrading gitlab-ce with system packages managent tool (apt-get), we strongly recommend to upgrade the gitlab-ce with a downloaded packages, You can search and download the packages at https://packages.gitlab.com/gitlab/gitlab-ce/. When downloaded,  cp the file into the container and install it with dpkg. You should not stop gitlab-ce, just install the new package as it starts, and choose no when it tries to reset your credential json file.
```bash
dpkg -i gitlab-ce_8.9.0-ce.0_amd64.deb
```
**Remember always backup before upgrading.**

###  Restore gitlab-ce
Restoring gitlab-ce databse can be done with the following commands.
```bash
# stop unicorn and sidekig processes.
gitlab-ctl stop unicorn
gitlab-ctl stop sidekiq
# copy goting-to-restore backup file  from /back to /back_tmp
cp /backup/1467331219_gitlab_backup.tar /back_tmp/
# restore  with the specified backup file
gitlab-rake gitlab:backup:restore BACKUP=1467331219
# reconfigure and restart gitlab-ce
gitlab-ctl reconfigure
gitlab-ctl start
```

## TODO
- [ ]  Add make lock file



[1]: https://www.docker.com/
[2]: https://docs.docker.com/docker-for-mac/

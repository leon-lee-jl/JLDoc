# TPages Common Info (TCI)
<img src="../_static/tp-common-logo.jpg" width="500" height="110" alt="Script_Options"/>


- [**Servers Profile**](#servers-profile)
- [**Tpages Websites**](#tpages-websites)
- [**Necessary Tunnels**](#necessary-tunnels)

## **Servers Profile**

<!--table-->
| Cluster | Node (SaltStack grains['id']) | OS   | Public Address| Intranet Address | Services | version | Ports Listening |Notes|
| ------------- | ------------- |------------- |------------- |------------- |------------- |------------- |------------- |------------- |
| Alicloud-CN     | www.go1978.com |CentOS release 6.3 (Final)/Kernel 2.6.32  |115.29.176.82| 10.161.176.27|nginx|1.4.3  |80, 443, 8006 |Port 8006 for nginx status, accessed by local only. |
|                 |             |                |                    |       |php-fpm| 5.3.3   |  - |     |
|                 |             |                |                    |       |gmond| 3.6.0  |8649 |Intranet only|
|                 |             |                |                    |       |memcached| 1.4.25   |11211 |Intranet only|
|                 |             |                |                    |       |coreseek|   4.0 (sphinx 1.11-dev) |9312, 9313 |Port 9312 for go1978 db, port 9313 for tpages db,  intranet only|
|                 |              |               |                    |             |salt-minion| 2016.3.1 | - |  |
|             | www.123go.net.cn| CentOS release 6.3 (Final)/Kernel 2.6.32      |121.40.124.151| 10.168.13.25|nginx|  1.4.3  |80, 443, 8006|Port 8006 for nginx status, accessed by local only.  |
|                 |               |              |                    |       |php-fpm| 5.4.37 |  --    |    |
|                 |             |                |                    |       |gmond| 3.6.0  |8649 |Intranet, and host with specified mac address(currently is 00:2a:6a:ed:42:b4, check [here][1] for reference) |
|                 |              |               |                    |             |salt-minion| 2016.3.1 | - |  |
|             | tpages.cn| CentOS release 6.5 (Final)/Kernel 2.6.32      |121.40.143.130| 10.168.22.21|nginx|  1.4.3  |80, 443, 8006| Port 8006 for nginx status, accessed by local only.|
|                 |             |                |                    |       |php-fpm| 5.3.3; 5.4.37 |  - |  5.3.3 for tpages.cn; 5.4.37 for socail.tpages.com   |
|                 |             |                |                    |       |sendmail| 8.14.4  |25 |Intranet only|
|                 |             |                |                    |       |gmond| 3.6.0  |8649 |Intranet only|
|                 |              |               |                    |             |salt-minion| 2016.3.1 | - |  |
|             |app. tpages.cn| CentOS Linux release 7.0.1406 (Core)/Kernel 3.10.0     |120.26.213.94| 10.117.105.214|nginx|  1.4.3  |80, 443, 8006, 8007| Port 8006 for nginx status, accessed by local only.  Port 8007 for hhvm status, accessed by local only.|
|                 |             |                |                    |       |hhvm| 3.11.0-dev  |  - |     |
|                 |             |                |                    |       |ntpd| 4.2.6p5  |123 |Intranet only|
|                 |             |                |                    |       |gmond| 3.6.0  |8649 |Intranet only|
|                 |              |               |                    |             |salt-minion| 2016.3.1 | - |  |
| Alicloud-INTL     | tpages.intl |CentOS Linux release 7.0.1406 (Core)/Kernel 3.10.0  |47.88.162.201| 10.45.241.56|nginx|1.4.3  |80, 443, 8006 |Port 8006 for nginx status, accessed by local only. |
|                 |             |                |                    |       |php-fpm| 5.3.3   |  - |     |
|                 |             |                |                    |       |ntpd| 4.2.6p5  |123 |Intranet only|
|                 |             |                |                    |       |gmond| 3.6.0  |8649 |Intranet only|
|                 |              |               |                    |             |salt-minion| 2016.3.0 | - |  |
|             | dev.tpages.intl| CentOS Linux release 7.0.1406 (Core)/Kernel 3.10.0      |47.88.151.151 | 10.45.246.58 |nginx|  1.4.3  |80, 443, 8006| Port 8006 for nginx status, accessed by local only. |
|                 |               |              |                    |       |php-fpm| 5.3.3; 5.6.18 |  --    | 5.6.18 for opencart.   |
|                 |             |                |                    |       |gmond| 3.6.0  |8649 |Intranet, and host with specified mac address(currently is 00:2a:6a:ed:42:b4, check [here][1] for reference) |
|                 |             |                |                    |       |ntpd| 4.2.6p5  |123 |Intranet only|
|                 |             |                |                    |       |vsftpd| 3.0.2  |21, 20 |  In port mode. |
|                 |              |               |                    |             |salt-minion| 2016.3.1 | - |  |
|   Local     |     homeyard         |   Ubuntu 14.04/Kernel 3.19.0      |   -------  | 192.168.3.217  |   salt-minion   | 2016.3.1 | - |  |
|                 |                              |                                                      |               |                          |   dnsmasq   | 2.68   |53   | Local DNS Server for testing local dev sites on mobile devices. ***Remember it's deployed in host machine, not in docker container.***|
|                 |                              |                                                      |               |                          |   docker/docker-compose   | 1.11.2/1.7.1 |---   | Docker test environment. |
|                 |                              |                                                      |               |                          |   gmond   | 3.6.0   |8649   | Intranet only. |
|                 |     sinospirit         |   OSX/ Yosemite 10.10.5     |   -------  | 192.168.3.17  |   salt-minion   | 2016.3.1 | - |  |
|                 |                              |                  |             |                          |  apache   | 2.4.16 | 80 | Sites for publishing php docs build from teamcity and some softwares used in docker build process. Config files located in “/private/etc/apache2/”, use apachectl to start or stop the process. |
|                 |                              |                  |             |                          |  mysqld   | 5.6.26 | 3306 | Mysql realtime replicated server for mysqld on itserver (192.168.3.15). Configs located in /usr/local/Cellar/mysql/5.6.26/, use mysql.server to start or stop the process. |
|                 |                              |                  |             |                          |  docker/docker-compose   | 1.10.3/1.6.2 | ---- | Docker production environment, root dir in "/tpages/Dockers" |
|                 |                              |                  |             |                          |  nrpe  | 09-06-2013 | 5667 |Nagios remote plugin executor, configs in "/etc/nrpe.cfg", check commands include "check_mysql_slave" and "check_mysqld". |
|                 |                              |                  |             |                          |  teamcity (java process)  | 9.1.6 | 8081 | root in /tpages/TeamCity-9.1.6 |
|                 |                              |                  |             |                          |  teamcity  build agent (java process) | --- | ---- |TC build agent for TC on sinospirit (192.168.3.17) root in /tpages/TeamCity-9.1.6/buildAgent |
|                 |                              |                  |             |                          |  teamcity  build agent  for itserver (java process) | --- | ---- |TC build agent for TC on itserver (192.168.3.15) root in /tpages/TeamCity-9.1.6/buildAgent_to_host15 |
|                 |                              |                  |             |                          |  youtrack  | 6.5 | 8080 | root in /tpages/YouTrack-6.5 |
|                 |     itserver         |   Windows Server 2008     |   -------  | 192.168.3.15  |   salt-minion   | 2016.3.0 | - | root dir located in "c:/salt", use system service manager to start or stop the process.  |
|                 |                          |                                            |               |                       |   nrpe   | 06-02-2006 | 5666 | Nagios remote plugin executor, root dir located in "C:\Program Files\nrpe_nt.0.8b-bin", check_commands include "check_mysqld", "check_svn", and "devtpages_update".  |
|                 |                          |                                            |               |                       |   mysqld   | 5.6.26 | 3306 | Local development database, root dir located in "D:\ProgramData\MySQL\MySQL Server 5.6"  |
|                 |                          |                                            |               |                       |   TeamCity   | 9.1.7 | 8081 | Root dir located in "D:\softwares\TeamCity"  |
|                 |                          |                                            |               |                       |   TeamCity Agent   |--- | ---- | TC build agent for itserver (192.168.3.17), root dir located in "D:\softwares\TeamCity\buildAgent".  |
|                 |                          |                                            |               |                       |   Visual SVN Server   |3.3.2 | 443 |Repost dir located in "D:\Repositories".  |
<!--endtable-->


## **Tpages Websites**
| Domain name |  Server (SaltStack grains['id']) | Root| RDS |   RDS Alias/Remarks   | DataBases|
| :------------- | :------------- | :------------- | :------------- | :------------- |:------------- |
| www.go1978.com     | www.go1978.com  | /go1978/portal/ | rdsimaq32n3eaza.mysql.rds.aliyuncs.com|  Production DB  | portal_go1978_com; mall_go1978_com |
| dev.123go.net.cn; mall.dev. 123go.net.cn; wiki.dev.123go.net.cn; edt.dev.123go.net.cn; api.dev.123go.net.cn     | www.go1978.com  | /go1978/devtpages/ | rdsbeybr2beybr2.mysql.rds.aliyuncs.com|  Development DB  | portal_tpages_com; mall_tpages_com |
| pig.tpages.com  | www.123go.net.cn  | /station/pig/ |rdsbeybr2beybr2.mysql.rds.aliyuncs.com | Development DB | pigcms_develop|
| orgpig.tpages.com  | www.123go.net.cn  | /station/orgpig/ |rdsbeybr2beybr2.mysql.rds.aliyuncs.com | Development DB | pigcms_native|
| devpig.tpages.com  | www.123go.net.cn  | /station/devpig/ |rdsbeybr2beybr2.mysql.rds.aliyuncs.com | Development DB | pigcms_ace |
| cs.123go.net.cn  | www.123go.net.cn  | /station/develop/cs/ |rdsbeybr2beybr2.mysql.rds.aliyuncs.com | Development DB | cs_mibew |
| corp.123go.net.cn  | www.123go.net.cn  | /station/corp/ |  ----- | ----- | ---- |
| http://121.40.124.151:8080/libreplan  | www.123go.net.cn  | /var/lib/tomcat6/webapps/libreplan/ |rdsbeybr2beybr2.mysql.rds.aliyuncs.com | Development DB | libreplan|
| tpages.cn; mall.tpages.cn; edt.tpages.cn; wiki.tpages.cn; api.tpages.cn     | tpages.cn  | /tpages/www/ | rdsimaq32n3eaza.mysql.rds.aliyuncs.com|  Production DB  | portal_tpages_com; mall_tpages_com |
| 90days.tpages.cn |tpages.cn |/tpages/www/DiscuzX/90days/ |  -----|   ----  |--- |
| social.tpages.com  | tpages.cn  | /tpages/social/ |rdsbeybr2beybr2.mysql.rds.aliyuncs.com | Development DB | pigcms_tpages_cn_db |
|app.tpages.cn| app.tpages.cn |/tpages/sns/public/|  rdsb44uvxvebxdnqyokb.mysql.rds.aliyuncs.com|   90days  |days90_tpages_com |
|messaging.tpages.cn| app.tpages.cn |/tpages/messaging-service/public/|  rdsb44uvxvebxdnqyokb.mysql.rds.aliyuncs.com|   90days  |messaging_service |
|en.tpages.club; en.mall.tpages.club; en.edt.tpages.club; en.wiki.tpages.club; en.api.tpages.club| tpages.intl |/tpagescom/www/en|  rds4578d88or47p4ff4s.mysql.rds.aliyuncs.com|   Tpages-intl |en_portal_tpages_com; en_mall_tpages_com |
|zh.tpages.club; zh.mall.tpages.club; zh.edt.tpages.club; zh.wiki.tpages.club; zh.api.tpages.club| tpages.intl |/tpagescom/www/zh|  rds4578d88or47p4ff4s.mysql.rds.aliyuncs.com|   Tpages-intl |zh_portal_tpages_com; zh_mall_tpages_com |
|zht.tpages.club; zht.mall.tpages.club; zht.edt.tpages.club; zht.wiki.tpages.club; zht.api.tpages.club| tpages.intl |/tpagescom/www/zh_t|  rds4578d88or47p4ff4s.mysql.rds.aliyuncs.com|   Tpages-intl |zht_portal_tpages_com; zht_mall_tpages_com |
|j.123go.net.cn| dev.tpages.intl| /opt/remi/php56/root/var/www/joomla | localhost| ---| joomla|
|https://oc.123go.net.cn/modded/| dev.tpages.intl| /opt/remi/php56/root/var/www/opencart | localhost| ---| opencart_modded|
|https://192.168.3.15| itserver| C:\Program Files\VisualSVN Server\WebUI | ---| ---| ------|
|https://192.168.3.15:8081| itserver| D:\softwares\TeamCity\webapps\ROOT | 192.168.3.15 | -------| teamcity_host15|
|http://192.168.3.17/Tpages/tests/js/index.min.html?noglobals= | sinospirit| /tpages/TeamCity-9.1.6/buildAgent/work/418204fd2819a9d3/eclipse/workplace/**[tests or src]** | --------- | JS tests| ----- |
|http://192.168.3.17/docs | sinospirit| /tpages/TeamCity-9.1.6/buildAgent/docs | --------- | Php published docs |  ---- |
|http://192.168.3.17/softwares | sinospirit| /tpages/Dockers/softwares | --------- | Offline large packages for docker build process.|  ---- |
|http://192.168.3.17:8001 | sinospirit| --------- | --------- | Gitlab-ce web; docker running container at gitlab-ce, dockerfile located in "/tpages/Dockers/tpages-gitlab-ce"|  ---- |
|http://192.168.3.17:8002| sinospirit| --------- | --------- | Satis web;  docker running container at satis-sinopia, dockerfile located in "/tpages/Dockers/tpages-satis-sinopia"|  ---- |
|http://192.168.3.17:3333| sinospirit| --------- | --------- | Satis build web;  docker running container at satis-sinopia, dockerfile located in "/tpages/Dockers/tpages-satis-sinopia"|  ---- |
|http://192.168.3.17:8003| sinospirit| --------- | --------- |  Sinopia web;  docker running container  at satis-sinopia, dockerfile located in "/tpages/Dockers/tpages-satis-sinopia"|  ---- |
|http://192.168.3.17:8004/cgi-bin/awstats.pl?config=***[tpages.cn or mall.tpages.cn or wiki.tpages.cn or edt.tpages.cn or api.tpages.cn or c.mall.tpages.cn]***| sinospirit|  /tpages/Dockers/volumes/operations/awstats-7.4/wwwroot
| -----| Awstats web, docker running container at operations, dockerfile located in "/tpages/Dockers/tpages-operations" | ----|
|http://192.168.3.17:8005| sinospirit | /tpages/Dockers/volumes/operations/nagios-4.1.1/share/ | -----| Nagios web, docker  running container at operations, dockerfile located in "/tpages/Dockers/tpages-operations" | ----|
|http://192.168.3.17:8006| sinospirit | /tpages/Dockers/volumes/operations/ganglia-3.7.2/www/ | -----| Ganglia web, docker  running container at operations, dockerfile located in "/tpages/Dockers/tpages-operations" | ----|
|https://192.168.3.17:8081 | sinospirit| /tpages/TeamCity-9.1.6/webapps/ROOT | 192.168.3.15 | ------ | teamcity_916 |
|https://192.168.3.17:8080 | sinospirit| /tpages/YouTrack-6.5/apps/youtrack/web | local file | ------ | DB files located in /tpages/YouTrack-6.5/youtrackdata/|


## **Necessary Tunnels**
| Cluster | Node (SaltStack grains['id']) |  Tunnel Type | Port Forwarding |   Notes |
| :------------ | :------------ | :------------- | :------------- | :------------- |
| Alicloud-CN    | www.go1978.com     | Remote  |  localhost:443-->localhost:4433| Ssh remote tunnel opened on itserver with local port 443 mapping to www,go1978.com local port 4433 for updating dev.123go.net.cn |
|              | tpages.cn     | Remote  |  localhost:443-->localhost:4433| Ssh remote tunnel opened on itserver with local port 443 mapping to tpages.cn local port 4433 for updating tpages.cn |
|              | www.123go.net.cn    | Remote  |  localhost:4505/4506-->10.168.13.25:4505/4506| Salt-master  remote tunnel opened on salt-master server with local ports 4505 and 4506 mapping to www.123go.net.cn  intranet  ports 4505 and 4506 for managing salt-minions. |
|  Alicoud-INTL            | dev.tpages.intl    | Remote  |  localhost:4505/4506-->10.45.246.58:4505/4506| Salt-master  remote tunnel opened on salt-master server with local ports 4505 and 4506 mapping to dev.tpages.intl  intranet  ports 4505 and 4506 for managing salt-minions. |

  [1]: http://192.168.3.17:8001/server/saltstack/blob/master/src/master/srv/salt/common/iptables.sls

# Docker image details

Firstly check the [Dockerfile](https://github.com/traas-stack/holoinsight/blob/main/scripts/docker/Dockerfile) the server uses.

Here are some details of Dockerfile:
1. Install azul openjdk at /opt/java8
2. Use [Supervisord](http://supervisord.org/introduction.html) to control our Java and Nginx processes.
3. Java/Nginx worker processes run as user 'admin'
4. The app fat jar location is /home/admin/app.jar
5. The log location is `/home/admin/logs/holoinsight-server/`
6. The front-end resources location is `/home/admin/holoinsight-server-static/`
7. `alias g="cd /home/admin/logs/holoinsight-server/"` 
8. The helper scripts location is `/home/admin/logs/api/` which is a soft link to `/home/admin/api/`. Considering that most of the time We will be in the `/home/admin/logs/holoinsight-server/` directory (using command 'g'), We put the api directory here and use syntax `sh ../api/basic/version` refers to them
9. Alias sc to `supervisorctl` (check `/usr/local/bin/sc`). So use `sc` or `sc status` to check app running status, use `sc start/stop/restart app` to control the app process. There are some helper scripts based on `sc` in `/home/admin/bin/`. 

# Run server
The result of [compile](../build/compile.md) is a Spring Boot fat jat `holoinsight-server.jar`.

```bash
java -jar holoinsight-server.jar
```

Next: 
- Check [Bootstrap configuration](bootstrap-configuration.md)
- [Deployment for testing](#deployment-for-testing)

# Deployment for testing
> This method is for quick local verification and is not suitable for production-level deployment.

Requirements:
1. JDK8
2. Maven
3. Docker
4. Docker compose v1.29.2

Now there is a test scene named `scene-default`. More test scenes will be added in the future.
Every scene has a `docker-compose.yaml` and some other resource files.

You can manually deploy a test scene using the following scripts:
```bash
# Deploy HoloInsight using docker-compose without building image from code
./test/scenes/${scene_name}/up.sh

# Build image from code, and then deploy HoloInsight using docker-compose
# debug=1 means enable Java remote debugger
build=1 debug=1 ./test/scenes/${scene_name}/up.sh

# Tear down HoloInsight
./test/scenes/${scene_name}/down.sh
```

For example:
```text
#./test/scenes/scene-default/up.sh
Removing network scene-default_default
WARNING: Network scene-default_default not found.
Creating network "scene-default_default" with the default driver
Creating scene-default_agent-image_1 ... done
Creating scene-default_ceresdb_1     ... done
Creating scene-default_mysql_1       ... done
Creating scene-default_mongo_1       ... done
Creating scene-default_prometheus_1  ... done
Creating scene-default_mysql-data-init_1 ... done
Creating scene-default_server_1          ... done
Creating scene-default_finish_1          ... done

[agent] install agent to server
copy log-generator.py to scene-default_server_1
copy log-alert-generator.py to scene-default_server_1

             Name                            Command                  State                                        Ports
---------------------------------------------------------------------------------------------------------------------------------------------------------
scene-default_agent-image_1       true                             Exit 0
scene-default_ceresdb_1           /tini -- /entrypoint.sh          Up (healthy)   0.0.0.0:50171->5440/tcp, 0.0.0.0:50170->8831/tcp
scene-default_finish_1            true                             Exit 0
scene-default_mongo_1             docker-entrypoint.sh mongod      Up (healthy)   0.0.0.0:50168->27017/tcp
scene-default_mysql-data-init_1   /init-db.sh                      Exit 0
scene-default_mysql_1             docker-entrypoint.sh mysqld      Up (healthy)   0.0.0.0:50169->3306/tcp, 33060/tcp
scene-default_prometheus_1        /bin/prometheus --config.f ...   Up             0.0.0.0:50172->9090/tcp
scene-default_server_1            /entrypoint.sh                   Up (healthy)   0.0.0.0:50175->80/tcp, 0.0.0.0:50174->8000/tcp, 0.0.0.0:50173->8080/tcp

Visit server at http://192.168.3.2:50175
Debug server at 192.168.3.2:50174 (if debug mode is enabled)
Exec server using ./server-exec.sh

Visit mysql at 192.168.3.2:50169
Exec mysql using ./mysql-exec.sh
```

```text
#./test/scenes/scene-default/down.sh
Stopping scene-default_server_1     ... done
Stopping scene-default_prometheus_1 ... done
Stopping scene-default_mysql_1      ... done
Stopping scene-default_mongo_1      ... done
Stopping scene-default_ceresdb_1    ... done
Removing scene-default_finish_1          ... done
Removing scene-default_server_1          ... done
Removing scene-default_mysql-data-init_1 ... done
Removing scene-default_prometheus_1      ... done
Removing scene-default_mysql_1           ... done
Removing scene-default_mongo_1           ... done
Removing scene-default_ceresdb_1         ... done
Removing scene-default_agent-image_1     ... done
Removing network scene-default_default
```


## Name isolation
When running scripts under `./test/scenes/${scene_name}/` such `up.sh`, you can configure an environment variable named `HOLOINSIGHT_DEV` to isolate image names and container names.

For example:  
Add `export HOLOINSIGHT_DEV=YOUR_PREFIX` to your `~/.bashrc`.  
And run:
```bash
build=1 ./test/scene/scene-default/up.sh
```
The names of the built images and running containers will be prefixed with "dev-YOUR_PREFIX".

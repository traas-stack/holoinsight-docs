# Notice

These test scenes are mainly used in the development and testing phase and <span style="color:red;">are not suitable for production</span>.

# Common scene shell scripts

There are many commonly used scripts under directory of each scene.

### up.sh

`up.sh` deploys current scene using docker-compose.

```bash
build=1 debug=1 up.sh
```

up.sh shell options:

| Option  | Description                                                                                                                             |
|---------|-----------------------------------------------------------------------------------------------------------------------------------------|
| build=1 | Build image(named `holoinsight/server:latest`) from source code.<br>This image exists in local docker, and is not pushed to Docker Hub. |
| debug=1 | Enable debug mode:<br>- Enable JVM remote debugger<br>- Start MySQL/MongoDB/Kibana Web UI                                               |

> You can generate Markdown tables using [Tables Generator](https://www.tablesgenerator.com/markdown_tables).

### after.sh

If this file exists and is executable, `up.sh` will call it after `docker-compose up`.  
We use this script to do the following things:

- Install `HoloInsight agent` into `HoloInsight server`, `demo-client` and `demo-server`
- Run Python scripts in `HoloInsight server` in background to generate demo logs
- Run ttyd `HoloInsight server` in background for easy access to server

### status.sh

`status.sh prints status of current deployed scene.

```text

                Name                              Command                  State                                                    Ports
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
scene-default_ceresdb_1         /tini -- /entrypoint.sh          Up (healthy)
...
scene-default_server_1          /entrypoint.sh                   Up (healthy)   0.0.0.0:10923->7681/tcp, 0.0.0.0:10924->80/tcp, 0.0.0.0:10922->8000/tcp, 0.0.0.0:10921->8080/tcp

┌───────────────────────┬──────────────────────────────────────────────┐
│  Component            │  Access                                      │
├───────────────────────┼──────────────────────────────────────────────┤
│  Server_UI            │  http://xx.xxx.xx.xxx:10924                  │
│  Server_JVM_Debugger  │  xx.xxx.xx.xxx:10922                         │
│  Server_Web_Shell     │  http://xx.xxx.xx.xxx:10923                  │
│  MySQL                │  xx.xxx.xx.xxx:10917                         │
│  MySQL_Web_UI         │  http://xx.xxx.xx.xxx:10916?db=holoinsight   │
│  ...                  │  ...                                         │
└───────────────────────┴──────────────────────────────────────────────┘

```

### down.sh

`down.sh` stops and removes current deployed scene.

### server-exec.sh

`server-exec.sh` is aliased to `docker exec -w /home/admin/logs/holoinsight-server -it ${server_container_id} bash`

### mysql-exec.sh

`server-exec.sh` is aliased to `docker exec -it ${mysql_container_id} mysql -uholoinsight -pholoinsight -Dholoinsight`

### server-update.sh

`server-update.sh` rebuilds HoloInsight server fat jar, copies the fat jar into server container, and then restarts server process.

# Test scenes

### scene-default

![scene-default deployment](../../resources/images/dev-guide/test/scene-default.jpg)
> Running this scene consumes about 5GB of memory.

The `scene-default` scene contains the following components:

- HoloInsight server
- [CeresDB](https://github.com/ceresdb/ceresdb)
- MySQL
- MongoDB
- Prometheus
- ElasticSearch
- [HoloInsight OTEL Collector](https://github.com/traas-stack/holoinsight-collector)

This scene also deploys several test applications for better integration testing and better demonstration effects.

- demo-client
- demo-server
- demo-redis

`demo-client` and `demo-server` have `skywalking-java-agent` enabled. They will report trace datum to `HoloInsight OTEL Collector`.

After all containers are started, the deployment script will copy HoloInsight-agent into it and execute agent in background using sidecar
mode.
Some Python scripts are mounted into `/home/admin/test` directory of `HoloInsight server`. In after.sh

Currently, running this test scene consumes about 5GB of memory.

Example:

```text
build=1 debug=1 ./test/scenes/scene-default/up.sh

# Stop previous deployment if exists
Stopping scene-default_demo-client_1   ... done
Stopping scene-default_demo-server_1   ... done
...

# Build server using maven
[INFO] Scanning for projects...
[INFO] ------------------------------------------------------------------------
[INFO] Detecting the operating system and CPU architecture
[INFO] ------------------------------------------------------------------------
...
[INFO] all-in-one-bootstrap 1.0.0-SNAPSHOT ................ SUCCESS [  0.747 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 14.320 s (Wall Clock)
[INFO] Finished at: 2023-04-20T16:39:13+08:00
[INFO] ------------------------------------------------------------------------

# Build server docker image
[+] Building 10.1s (29/29) FINISHED
 => [internal] load .dockerignore                                                                                                                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                                                                                                                          0.0s
 => [internal] load build definition from Dockerfile
 ....
 => => sending tarball                                                                                                                                                                                                                                                   3.4s
 => importing to docker

# Start deployment 
debug enabled
Creating network "scene-default_default" with the default driver
Creating volume "scene-default_share" with default driver
Creating scene-default_grafana_1     ... done
Creating scene-default_agent-image_1 ... done
...

# Deployment result

                Name                              Command                  State                                                    Ports
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
scene-default_ceresdb_1         /tini -- /entrypoint.sh          Up (healthy)
...
scene-default_server_1          /entrypoint.sh                   Up (healthy)   0.0.0.0:10923->7681/tcp, 0.0.0.0:10924->80/tcp, 0.0.0.0:10922->8000/tcp, 0.0.0.0:10921->8080/tcp

┌───────────────────────┬──────────────────────────────────────────────┐
│  Component            │  Access                                      │
├───────────────────────┼──────────────────────────────────────────────┤
│  Server_UI            │  http://xx.xxx.xx.xxx:10924                  │
│  Server_JVM_Debugger  │  xx.xxx.xx.xxx:10922                         │
│  Server_exec          │  ./server-exec.sh                            │
│  Server_Web_Shell     │  http://xx.xxx.xx.xxx:10923                  │
│  MySQL                │  xx.xxx.xx.xxx:10917                         │
│  MySQL_exec           │  ./mysql-exec.sh                             │
│  MySQL_Web_UI         │  http://xx.xxx.xx.xxx:10916?db=holoinsight   │
│  MongoDB_Web_UI       │  http://xx.xxx.xx.xxx:10918/db/holoinsight/  │
│  Kibana_Web_UI        │  http://xx.xxx.xx.xxx:10920                  │
│  Grafana_Web_UI       │  http://xx.xxx.xx.xxx:10915                  │
└───────────────────────┴──────────────────────────────────────────────┘
```

# Misc

## Update database

There is a service named `mysql-data-init` in `docker-compose.yaml`. It is used to initialize database tables and pre-populate some data for
its test scene.  
This service does three things:

1. mounts `server/extension/extension-common-flyway/src/main/resources/db/migration` to `/sql/0migration` in container
2. mounts `${test_scene_dir}/data.sql` to `/sql/1data/V999999__data.sql` in container
3. executes all sql scripts lexicographically under `/sql` in container

Most scenes will choose to reuse the `data.sql` of scene-default, and the docker-compose of these scenes will refer to the `data.sql` of
scene-default instead of copying a copy to their own directory.

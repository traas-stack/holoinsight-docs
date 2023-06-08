# Introduction
This document introduces how to quickly deploy a server-side demo and access it with a browser.

# Deploy using docker-compose
> We heavily use docker-compose for internal development and E2E testing.  
> Check more details at [Development for testing](../dev-guide/run/README.md#deployment-for-testing).

Requirements:
1. [docker](https://docs.docker.com/engine/install/) & [docker-compose](https://docs.docker.com/compose/install/other/)(==v1.29) installed
2. Linux or Mac environment

To verify whether docker compose is already installed:
```bash
docker-compose version
```

1. Clone the repo
```bash
git clone https://github.com/traas-stack/holoinsight.git --depth 1 
```

2. Run deploy script
```bash
./test/scenes/scene-default/up.sh
``` 
This script deploy the whole server side, and it also installs a HoloInsight Agent (VM mode) inside HoloInsight Server container. This usage is only for demonstration and is not applicable to production environment.

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

3. Visit HoloInsight at http://192.168.3.2:50175.  
   Check [product documentation](https://github.com/traas-stack/holoinsight-docs/blob/main/docs/src/en/quickstart/quick-start.md)

4. Stop the deployment
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


# Deploy using k8s
> Now it is recommended to refer to [this document](../operations/deployment/k8s.md) to deploy based on K8s

Requirements:
1. k8s cluster
2. Linux or Mac environment


1. clone the repo
```bash
git clone https://github.com/traas-stack/holoinsight.git --depth 1 
```

2. deploy k8s resources
```bash
sh ./deploy/examples/k8s/overlays/example/apply.sh
```
> Notice: Your k8s user must have the permission to create ClusterRole.

Use following script to uninstall HoloInsight from k8s cluster.
```bash
# sh ./deploy/examples/k8s/overlays/example/delete.sh
```

3. Visit HoloInsight  
   Visit http://localhost:8080  
   Check [product documentation](https://github.com/traas-stack/holoinsight-docs/blob/main/docs/src/en/quickstart/quick-start.md)

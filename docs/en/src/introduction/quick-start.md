# Introduction
This document introduces how to quickly deploy a server-side demo and access it with a browser.


# Deploy using docker-compose
Requirements:
1. [docker](https://docs.docker.com/engine/install/) & [docker-compose](https://docs.docker.com/compose/install/other/)(**>=v1.29 || >=v2**) installed
2. Linux or Mac environment

To verify whether docker compose is already installed:
```bash
# V1
docker-compose version

# V2
docker compose version
```

> Follow the [guide](#install-docker-compose) in [appendix](#appendix) to install docker-compose quickly.


1. clone the repo
```bash
git clone https://github.com/traas-stack/holoinsight.git --depth 1 
```

2. run deploy script
```bash
sh ./deploy/examples/docker-compose/up.sh
 
# Users in China can use the following script for better network access.
# sh ./deploy/examples/docker-compose/up.sh cn
``` 
This script will also install an agent inside holoinsight-server container. This usage is only for demonstration and is not applicable to production environment.

3. visit holoinsight  
   visit http://localhost:8080  
   Check [product documentation](https://github.com/traas-stack/holoinsight-docs/blob/main/docs/src/en/quickstart/quick-start.md)

# Deploy using k8s
Requirements:
1. k8 cluster
2. Linux or Mac environment


1. clone the repo
```bash
git clone https://github.com/traas-stack/holoinsight.git --depth 1 
```

2. deploy k8s resources
```bash
sh ./deploy/examples/k8s/overlays/example/apply.sh

# Users in China can use the following script for better network access.
# sh ./deploy/examples/k8s/overlays/example-cn/apply.sh 
```
> Notice: Your k8s user must has the permission to create ClusterRole.

Use following script to uninstall holoinsight from k8s cluster.
```bash
# sh ./deploy/examples/k8s/overlays/example/delete.sh
```

3. visit holoinsight  
   visit http://localhost:8080  
   Check [product documentation](https://github.com/traas-stack/holoinsight-docs/blob/main/docs/src/en/quickstart/quick-start.md)

# Appendix
#### Install docker-compose
quick install docker-compose V2:
```bash
sudo curl -SL https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose && sudo chmod a+x /usr/local/bin/docker-compose
```

Users in China can use the following script for better network access.
```bash
docker run --name holoinsight-tools -d registry.cn-hangzhou.aliyuncs.com/holoinsight-examples/tools:latest && \
  docker cp holoinsight-tools:/docker-compose . && \
  docker rm -f holoinsight-tools
```

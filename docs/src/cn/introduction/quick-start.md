# 介绍
这份文档介绍如何快速部署一个服务端示例，并且用浏览器来访问它。


# 使用 docker-compose 部署
先决条件:
1. 已安装 [docker](https://docs.docker.com/engine/install/) & [docker-compose](https://docs.docker.com/compose/install/other/)(**>=v1.29 || >=v2**)
2. 有 Linux 或 Mac 环境

检查 `docker compose` 的版本：
```bash
# V1
docker-compose version

# V2
docker compose version
```

> 可以参考附录里的 [安装-docker-compose](#安装-docker-compose).

1. 克隆仓库
```bash
git clone https://github.com/traas-stack/holoinsight.git --depth 1 
```

2. 运行部署脚本
```bash
sh ./deploy/examples/docker-compose/up.sh
 
# 中国的用户可以使用如下的脚本获得更好的网络访问
# sh ./deploy/examples/docker-compose/up.sh cn
``` 
这个脚本会同时部署一个 holoinsight-agent 到 holoinsight-server 容器中，这种用法仅仅用于演示，不适用于生产环境。

3. 访问 Holoinsight  
   访问 http://localhost:8080  
   产品的使用方法可以参考[这个文档](https://github.com/traas-stack/holoinsight-docs/blob/main/docs/src/cn/product/quick-start.md)。

# 使用 k8s 部署
先决条件:
1. 有 k8 集群
2. 有 Linux 或 Mac 环境
   <br/>

1. 克隆仓库
```bash
git clone https://github.com/traas-stack/holoinsight.git --depth 1 
```

2. 部署 k8s 资源
```bash
sh ./deploy/examples/k8s/overlays/example/apply.sh

# 中国的用户可以使用如下的脚本获得更好的网络访问。
# sh ./deploy/examples/k8s/overlays/example-cn/apply.sh 
```
> Notice: 你的 k8s 用户必须有权限创建 ClusterRole。

使用如下脚本将 Holoinsight 从 k8s 集群中卸载。
```bash
# sh ./deploy/examples/k8s/overlays/example/delete.sh
```

3. 访问 Holoinsight  
   访问 http://localhost:8080  
   产品的使用方法可以参考[这个文档](https://github.com/traas-stack/holoinsight-docs/blob/main/docs/src/cn/product/quick-start.md)。

# 附录
#### 安装 docker-compose
快速安装 docker-compose V2:
```bash
sudo curl -SL https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose && sudo chmod a+x /usr/local/bin/docker-compose
```

中国的用户可以使用如下的脚本获得更好的网络访问。
```bash
docker run --name holoinsight-tools -d registry.cn-hangzhou.aliyuncs.com/holoinsight-examples/tools:latest && \
  docker cp holoinsight-tools:/docker-compose . && \
  docker rm -f holoinsight-tools
```

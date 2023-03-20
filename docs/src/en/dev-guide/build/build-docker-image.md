# Build server docker image

## Build multi arch docker image

Build requirements:
- Linux or Mac
- JDK 8
- Maven
- Docker
- [Docker buildx](https://docs.docker.com/build/install-buildx/)

```bash
sh ./scripts/docker/buildx.sh
```

build result:
- holoinsight/server:temp-amd64-linux
- holoinsight/server:temp-arm64v8-linux

sample output
```text
use /root/.docker/cli-plugins/buildx
[+] Building 6.1s (32/32) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                                                                                                                     0.0s
 => => transferring dockerfile: 2.54kB                                                                                                                                                                                                                                   0.0s
 => [internal] load .dockerignore                                                                                                                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                                                                                                                          0.0s
 => [internal] load metadata for docker.io/library/centos:7                                                                                                                                                                                                              1.8s
 => [internal] load metadata for docker.io/azul/zulu-openjdk:8                                                                                                                                                                                                           0.0s
 => [auth] library/centos:pull token for registry-1.docker.io                                                                                                                                                                                                            0.0s
 => [internal] load build context                                                                                                                                                                                                                                        0.8s
 => => transferring context: 127.70MB                                                                                                                                                                                                                                    0.8s
 => [stage-1  1/24] FROM docker.io/library/centos:7@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4                                                                                                                                              0.0s
 => [jdk 1/1] FROM docker.io/azul/zulu-openjdk:8                                                                                                                                                                                                                         0.0s
 => CACHED [stage-1  2/24] COPY --from=jdk /usr/lib/jvm/zulu8 /opt/java8                                                                                                                                                                                                 0.0s
 => CACHED [stage-1  3/24] RUN groupadd --gid 500 admin &&   useradd admin -s /bin/bash --uid 500 --gid 500 -G root                                                                                                                                                      0.0s
 => CACHED [stage-1  4/24] RUN ln -s /opt/java8 /usr/local/java                                                                                                                                                                                                          0.0s
 => CACHED [stage-1  5/24] RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&   yum -y -q install epel-release && yum install -y -q sudo net-tools iproute dstat which supervisor stress unzip jq screen nginx wget telnet cronolog less lsof gettext &&    0.0s
 => CACHED [stage-1  6/24] RUN wget -qO /opt/arthas.zip https://arthas.aliyun.com/download/latest_version?mirror=aliyun &&     unzip -d /opt/arthas /opt/arthas.zip >/dev/null &&     rm /opt/arthas.zip                                                                 0.0s
 => CACHED [stage-1  7/24] COPY scripts/docker/sc /usr/local/bin/                                                                                                                                                                                                        0.0s
 => CACHED [stage-1  8/24] COPY scripts/docker/ensure_supervisord.sh /usr/local/bin/                                                                                                                                                                                     0.0s
 => CACHED [stage-1  9/24] COPY scripts/docker/supervisord.conf /etc/supervisord.conf                                                                                                                                                                                    0.0s
 => CACHED [stage-1 10/24] RUN echo 'export LANG=zh_CN.UTF-8' >> /etc/profile &&   echo 'LC_ALL=zh_CN.UTF-8' >> /etc/profile &&   echo 'PS1="\n\e[1;37m[\e[m\e[1;32m\u\e[m\e[1;33m@\e[m\e[1;35m\h\e[m \e[1;35m`hostname`\e[m \e[4m\`pwd\`\e[m\e[1;37m]\e[m\e[1;36m\e[m\  0.0s
 => CACHED [stage-1 11/24] COPY scripts/docker/bin/app.ini /etc/supervisord.d/app.ini                                                                                                                                                                                    0.0s
 => CACHED [stage-1 12/24] RUN true                                                                                                                                                                                                                                      0.0s
 => CACHED [stage-1 13/24] COPY --chown=admin:admin scripts/docker/bin/*.sh /home/admin/bin/                                                                                                                                                                             0.0s
 => CACHED [stage-1 14/24] RUN true                                                                                                                                                                                                                                      0.0s
 => CACHED [stage-1 15/24] COPY scripts/docker/entrypoint.sh /entrypoint.sh                                                                                                                                                                                              0.0s
 => CACHED [stage-1 16/24] RUN true                                                                                                                                                                                                                                      0.0s
 => CACHED [stage-1 17/24] RUN chown -R admin:admin /home/admin                                                                                                                                                                                                          0.0s
 => CACHED [stage-1 18/24] WORKDIR /home/admin                                                                                                                                                                                                                           0.0s
 => CACHED [stage-1 19/24] COPY scripts/api /home/admin/api                                                                                                                                                                                                              0.0s
 => CACHED [stage-1 20/24] COPY scripts/docker/nginx.conf /etc/nginx/nginx.conf                                                                                                                                                                                          0.0s
 => CACHED [stage-1 21/24] COPY scripts/docker/dist.zip /home/admin/dist.zip                                                                                                                                                                                             0.0s
 => CACHED [stage-1 22/24] RUN unzip -d /home/admin/holoinsight-server-static/ /home/admin/dist.zip                                                                                                                                                                      0.0s
 => [stage-1 23/24] COPY --chown=admin:admin server/all-in-one/all-in-one-bootstrap/target/holoinsight-server.jar /home/admin/app.jar                                                                                                                                    1.9s
 => [stage-1 24/24] RUN echo `date` > /home/admin/build-time                                                                                                                                                                                                             0.2s
 => exporting to image                                                                                                                                                                                                                                                   1.3s
 => => exporting layers                                                                                                                                                                                                                                                  1.3s
 => => writing image sha256:c530e069bede114129eec4df3a55452bc37815967071c9e0f2fe04e871a2329e                                                                                                                                                                             0.0s
 => => naming to docker.io/holoinsight/server:temp-amd64-linux                                                                                                                                                                                                           0.0s
use /root/.docker/cli-plugins/buildx
[+] Building 4.5s (32/32) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                                                                                                                     0.0s
 => => transferring dockerfile: 32B                                                                                                                                                                                                                                      0.0s
 => [internal] load .dockerignore                                                                                                                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                                                                                                                          0.0s
 => [internal] load metadata for docker.io/azul/zulu-openjdk:8                                                                                                                                                                                                           1.7s
 => [internal] load metadata for docker.io/library/centos:7                                                                                                                                                                                                              0.0s
 => [auth] azul/zulu-openjdk:pull token for registry-1.docker.io                                                                                                                                                                                                         0.0s
 => [internal] load build context                                                                                                                                                                                                                                        0.0s
 => => transferring context: 2.84kB                                                                                                                                                                                                                                      0.0s
 => [stage-1  1/24] FROM docker.io/library/centos:7                                                                                                                                                                                                                      0.0s
 => [jdk 1/1] FROM docker.io/azul/zulu-openjdk:8@sha256:c732e7f24fceef589c740a2b410e478100473b969461a89dd7c655e73d38b614                                                                                                                                                 0.0s
 => CACHED [stage-1  2/24] COPY --from=jdk /usr/lib/jvm/zulu8 /opt/java8                                                                                                                                                                                                 0.0s
 => CACHED [stage-1  3/24] RUN groupadd --gid 500 admin &&   useradd admin -s /bin/bash --uid 500 --gid 500 -G root                                                                                                                                                      0.0s
 => CACHED [stage-1  4/24] RUN ln -s /opt/java8 /usr/local/java                                                                                                                                                                                                          0.0s
 => CACHED [stage-1  5/24] RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&   yum -y -q install epel-release && yum install -y -q sudo net-tools iproute dstat which supervisor stress unzip jq screen nginx wget telnet cronolog less lsof gettext &&    0.0s
 => CACHED [stage-1  6/24] RUN wget -qO /opt/arthas.zip https://arthas.aliyun.com/download/latest_version?mirror=aliyun &&     unzip -d /opt/arthas /opt/arthas.zip >/dev/null &&     rm /opt/arthas.zip                                                                 0.0s
 => CACHED [stage-1  7/24] COPY scripts/docker/sc /usr/local/bin/                                                                                                                                                                                                        0.0s
 => CACHED [stage-1  8/24] COPY scripts/docker/ensure_supervisord.sh /usr/local/bin/                                                                                                                                                                                     0.0s
 => CACHED [stage-1  9/24] COPY scripts/docker/supervisord.conf /etc/supervisord.conf                                                                                                                                                                                    0.0s
 => CACHED [stage-1 10/24] RUN echo 'export LANG=zh_CN.UTF-8' >> /etc/profile &&   echo 'LC_ALL=zh_CN.UTF-8' >> /etc/profile &&   echo 'PS1="\n\e[1;37m[\e[m\e[1;32m\u\e[m\e[1;33m@\e[m\e[1;35m\h\e[m \e[1;35m`hostname`\e[m \e[4m\`pwd\`\e[m\e[1;37m]\e[m\e[1;36m\e[m\  0.0s
 => CACHED [stage-1 11/24] COPY scripts/docker/bin/app.ini /etc/supervisord.d/app.ini                                                                                                                                                                                    0.0s
 => CACHED [stage-1 12/24] RUN true                                                                                                                                                                                                                                      0.0s
 => CACHED [stage-1 13/24] COPY --chown=admin:admin scripts/docker/bin/*.sh /home/admin/bin/                                                                                                                                                                             0.0s
 => CACHED [stage-1 14/24] RUN true                                                                                                                                                                                                                                      0.0s
 => CACHED [stage-1 15/24] COPY scripts/docker/entrypoint.sh /entrypoint.sh                                                                                                                                                                                              0.0s
 => CACHED [stage-1 16/24] RUN true                                                                                                                                                                                                                                      0.0s
 => CACHED [stage-1 17/24] RUN chown -R admin:admin /home/admin                                                                                                                                                                                                          0.0s
 => CACHED [stage-1 18/24] WORKDIR /home/admin                                                                                                                                                                                                                           0.0s
 => CACHED [stage-1 19/24] COPY scripts/api /home/admin/api                                                                                                                                                                                                              0.0s
 => CACHED [stage-1 20/24] COPY scripts/docker/nginx.conf /etc/nginx/nginx.conf                                                                                                                                                                                          0.0s
 => CACHED [stage-1 21/24] COPY scripts/docker/dist.zip /home/admin/dist.zip                                                                                                                                                                                             0.0s
 => CACHED [stage-1 22/24] RUN unzip -d /home/admin/holoinsight-server-static/ /home/admin/dist.zip                                                                                                                                                                      0.0s
 => [stage-1 23/24] COPY --chown=admin:admin server/all-in-one/all-in-one-bootstrap/target/holoinsight-server.jar /home/admin/app.jar                                                                                                                                    0.9s
 => [stage-1 24/24] RUN echo `date` > /home/admin/build-time                                                                                                                                                                                                             0.4s
 => exporting to image                                                                                                                                                                                                                                                   1.4s
 => => exporting layers                                                                                                                                                                                                                                                  1.4s
 => => writing image sha256:6cc3d08d49f05a439d9a02ea33191da8f99562250650db009dcc0a937551f825                                                                                                                                                                             0.0s
 => => naming to docker.io/holoinsight/server:temp-arm64v8-linux                                                                                                                                                                                                         0.0s
```


# Build agent docker image
Build requirements:
- Linux or Mac
- Docker
- [Docker buildx](https://docs.docker.com/build/install-buildx/)

## Build agent docker image for current arch
```bash
./scripts/docker/build.sh

# Users in China can use GOPROXY to speed up building
GOPROXY="https://goproxy.cn,direct" ./scripts/docker/build.sh
```

build result:
- holoinsight/agent:latest (contains only current arch)

> The build result will be loaded into Docker.

## Build multi arch docker image
```bash
./scripts/docker/buildx.sh

# Users in China can use GOPROXY to speed up building
GOPROXY="https://goproxy.cn,direct" ./scripts/docker/buildx.sh
```

build result:
- holoinsight/agent:latest (contains linux/amd64 and linux/arm64/v8 platforms)

> The build result will upload to Docker Hub.

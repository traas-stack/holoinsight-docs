# 编译 Server

Compile 要求：
- JDK 8
- Maven

```bash
sh ./scripts/all-in-one/build.sh
```

编译结果:
- server/all-in-one/target/holoinsight-server.jar : 一个 Spring Boot 的 fat jar

# 编译 Agent

编译要求：
1. Golang 1.19 or docker

使用 Go 编译 agent：
```bash
./scripts/build/build-using-go.sh
```

使用 Docker 编译 agent：
```bash
./scripts/build/build-using-docker.sh
```

编译结果:
- build/linux-amd64/bin/agent
- build/linux-amd64/bin/helper

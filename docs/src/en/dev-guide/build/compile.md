# Compile Server

Compile requirements:
- JDK 8
- Maven

```bash
sh ./scripts/all-in-one/build.sh
```

compile result:
- server/all-in-one/target/holoinsight-server.jar : A Spring Boot fat jar

# Compile Agent

Compile requirements:
1. Golang 1.19 or docker

Compile using go:
```bash
./scripts/build/build-using-go.sh
```

Compile using docker:
```bash
./scripts/build/build-using-docker.sh
```

compile result:
- build/linux-amd64/bin/agent
- build/linux-amd64/bin/helper

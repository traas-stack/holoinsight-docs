# Build server docker image
Build requirements:
- Linux or Mac
- JDK 8
- Maven
- Docker
- [Docker buildx](https://docs.docker.com/build/install-buildx/)

## Build server-base docker image for multi arch
```bash
./scripts/docker/base/build.sh
```

build result:
- holoinsight/server-base:$tag

> The image will be pushed to Docker Hub.

## Build server docker image for current arch

```bash
./scripts/docker/build.sh
```

build result:
- holoinsight/server:latest

> The image will only be loaded into local Docker.

## Build server docker image for multi arch

```bash
./scripts/docker/buildx.sh
```

build result:
- holoinsight/server:latest

> The image will be pushed to Docker Hub.


# Build agent docker image
Build requirements:
- Linux or Mac
- Docker
- [Docker buildx](https://docs.docker.com/build/install-buildx/)

## Build agent-builder docker image
`holoinsight/agent-builder` Docker image containing golang env for agent can be used to build agent binaries.

```bash
./scripts/build/agent-builder/build.sh
```

build result:
- holoinsight/agent-builder:$tag

> The image will be pushed to Docker Hub.

## Build agent-base docker image
`holoinsight/agent-base`

```bash
./scripts/docker/agent-base/build.sh
```

build result:
- holoinsight/agent-base:$tag

> The image will be pushed to Docker Hub.

## Build agent docker image for current arch
```bash
./scripts/docker/build.sh

# Users in China can use GOPROXY to speed up building
GOPROXY="https://goproxy.cn,direct" ./scripts/docker/build.sh
```

build result:
- holoinsight/agent:latest (contains only current arch)

> The image will only be loaded into local Docker.

## Build multi arch docker image
```bash
./scripts/docker/buildx.sh

# Users in China can use GOPROXY to speed up building
GOPROXY="https://goproxy.cn,direct" ./scripts/docker/buildx.sh
```

build result:
- holoinsight/agent:latest (contains linux/amd64 and linux/arm64/v8 platforms)

> The image will be pushed to Docker Hub.

# Notice
Some build scripts require the permission to push images to Docker Hub.  
These scripts can only be executed by core developers of HoloInsight.

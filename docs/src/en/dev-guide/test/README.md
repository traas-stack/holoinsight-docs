# E2E testing
Check [this doc](https://github.com/traas-stack/holoinsight/blob/main/test/README.md) for more details.

```bash
# Run all E2E tests without building image from code
./scripts/test/e2e/all.sh

# Build image from code, and then run all E2E tests
build=1 ./scripts/test/e2e/all.sh
```

## Deployment for testing
> This method is for quick local verification and is not suitable for production-level deployment. 

Now there is a test scene named `scene-default`. More test scenes will be added in the future.
Every scene has a `docker-compose.yaml` and some other resource files.

You can manually deploy a test scene using the following scripts:
```bash
# Deploy HoloInsight using docker-compose without building image from code
./test/scenes/${scene_name}/up.sh

# Build image from code, and then deploy HoloInsight using docker-compose
build=1 ./test/scenes/${scene_name}/up.sh

# Tear down HoloInsight
./test/scenes/${scene_name}/down.sh
```

# Agent bootstrap configuration

When the agent starts, it will load the initial configuration from `$agent_home/agent.yaml`.
If `$agent_home/agent.yaml` does not exist, the configuration will be loaded from `$agent_home/conf/agent.yaml`.

Some environment variables have higher priority, they can override some configuration items.
> Please check: appconfig.go

# Agent.yaml example

```yaml
# Common
apikey: YOUR_API_KEY
workspace: default
cluster: default
registry:
  addr: registry.holoinsight-server
  secure: true
gateway:
  addr: registry.holoinsight-server
  secure: true

version:
basic:
central:

data:
  metric:
    # Only used in k8s/daemonset mode
    refLabels:
      items:
      - key: serviceName
        labels: [ "foo.bar.serviceName1", "foo.bar.serviceName2" ]
        defaultValue: "-"

# Only used in k8s/daemonset mode
k8s:
  meta:
    appRef: ""
    hostnameRef: ""
    nodeHostnameRef: ""
    sidecarCheck: ""
    sandbox:
      labels: { }

# Only used in VM mode
app: "this field is only used in VM mode"

```

### Common

#### apikey
`apikey` is required.
```yaml
apikey: YOUR_API_KEY
```

#### workspace
`workspace` is used to support `workspace` concept in the product layer. It will be added as a metric tag to separator metrics.

```yaml
workspace: "default"
```
If workspace value is empty, "default" will be used.

#### cluster
`cluster` is a unique string under same tenant(determined by the apikey). It is used to isolate metadata.
If you have 2 k8s clusters, and you deploy 2 `holoinsight-agent` daemonset for these 2 clusters respectively with same `apikey`(so the same tenant).
```yaml
cluster: "" 
```
If cluster value is empty, "default" will be used.

#### registry
`registry` configures the registry address.
```yaml
gateway:
  addr: registry.holoinsight-server:443
  # Whether to use HTTPS.
  secure: true
```

If port of addr is empty, 7202 will be used.

#### gateway
`gateway` configures the gateway address.

```yaml
gateway:
  addr: registry.holoinsight-server:443
  # Whether to use HTTPS.
  secure: true
```

If port of addr is empty, 19610 will be used.

### k8s daemonset
```yaml
k8s:
  meta:
    # appRef defines how to extract app tag from pod meta 
    appRef: "label:foo.AppName,label:bar/app-name,env:BAZ_APPNAME"
    # appRef defines how to extract hostname tag from pod meta
    hostnameRef: "label:foo/hostname,env:HOSTNAME"
    nodeHostnameRef: ""
    #  sidecarCheck is used to determine whether a container is a sidecar
    sidecarCheck: "env:IS_SIDECAR:true,name:sidecar"
    sandbox:
      labels: { }

data:
  metric:
    # Ref pod labels as tags
    refLabels:
      items:
      - key: appId
        # Find first not empty label value as appId tag
        labels: [ "foo.bar.baz/app-id", "foo.bar.baz/APPID" ]
        defaultValue: "-"
      - key: envId
        labels: [ "foo.bar.baz/env-id" ]
        defaultValue: "-"
      - key: serviceName
        labels: [ "foo.bar.baz/service-name" ]
        defaultValue: "-"

```

`appRef: "label:foo.AppName,label:bar/app-name,env:BAZ_APPNAME"` means extracting the app tag from the following sources, the first non-empty one takes precedence:
- a pod label named "foo.AppName"
- a pod label named "bar/app-name"
- env named "BAZ_APPNAME" of any container of the pod 

`sidecarCheck: "env:IS_SIDECAR:true,name:sidecar"` means is a container has env `IS_SIDECAR=true`, or its container name contains 'sidecar' then it's a sidecar container.

`refLabels` is used to ref pod labels as metric tags.

### VM mode

```yaml
app: "your app name"
```

### ENV
There are some magic environment variables internally, their generation is relatively random, and they are not well planned.  
But there are already there, and they cannot be deleted in a short time. These environment variables are not recommended. They may be deleted in a future version.

- HOSTFS: /hostfs
- DOCKER_SOCK: /var/run/docker.sock

> Please check: appconfig.go

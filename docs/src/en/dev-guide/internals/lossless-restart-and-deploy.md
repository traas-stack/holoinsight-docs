# Lossless restart and deploy

## Lossless restart
When the Agent is ready to exit due to receiving a SIGTERM signal, it saves its task execution state to `$CWD/data/state` (usually `/usr/local/holoinsight/agent/data/state`).

When the Agent starts, it tries to load `$CWD/data/state` (valid for 2 minutes from creation) to restore task state.

# Lossless deploy/upgrade
Config maxSurge>0 in k8s yaml:
```yaml
  updateStrategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
```

After the agent starts, it will listen to `$CWD/data/transfer.sock`.

When holoinsight-agent is upgraded using maxSurge mode through k8s, k8s will first create a new pod, and then delete the old pod after the new pod is ready.

When the new pod starts, it will try to connect `$CWD/data/transfer.sock` to the old pod for state transfer. After the state transfer is completed, the new pod starts to work normally, and the old pod is still alive but not working, waiting for k8s to reclaim resources.

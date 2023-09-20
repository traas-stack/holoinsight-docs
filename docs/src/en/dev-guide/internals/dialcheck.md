# Dialcheck
Agent code: [pkg/plugin/input/dialcheck](https://github.com/traas-stack/holoinsight-agent/tree/main/pkg/plugin/input/dialcheck)

## Overview
Dialcheck c the connectivity of the target address port.

```go
package dialcheck

type Config struct {
    // tcp or udp
    Network     string        `json:"network"`
    // ip:port
    Addr        string        `json:"addr"`
    // connection timeout
    Timeout     time.Duration `json:"timeout"`
    // How many times to check connection. If any successful connection, the final result is success.
    Times       int           `json:"times"`
    // networkMode AGENT: create network connection from agent to target addr
    // networkMode POD: using `docker exec` to check target addr inside the target pod 
    NetworkMode string        `json:"networkMode"`
}
```

Result:
- up: 1 for network up or else 0
- down: 1 for network down or else 0
- cost: average detection time

> The value of the cost field is obtained by counting the execution time of net.Dial(), and it is not necessarily accurate.

If the task from server side does not specify a 'metircPreifx', "dialcheck_" will be used.
So the final metric results will be:
- dialcheck_up
- dialcheck_down
- dialcheck_cost

# NetworkMode details
When networkMode is 'AGENT', agent creates network connection from agent to target addr. This works for most scenarios.  

When networkMode is 'POD', agent uses 'docker exec' to run the helper binary, which is installed when agent discovers the pod.
This helper binary will execute the logic of network detection.
This method is suitable for scenarios with network isolation (between agent and target pod).

In addition, networkMode may add a new value of "NETNS" (but it has not yet been implemented).
As the name suggests, it uses Linux's `setns` to enter the network namespace of the target container, and then performs network probing.  
It can also break through the network isolation in some scenarios.

# Log time parsing
The parsing of the timestamp has the following steps:
1. To extract the time string, you need to use elect to extract the time string
2. Determine the time zone, if the time zone of the container is empty, then use the time zone
3. Try to parse the time string into a millisecond timestamp, this step needs to understand the format and layout of the time string

The extraction configuration of the timestamp is defined by the following structure:
```go
type TimeConf struct {
    Type string `json:"type"`
    Elect *Elect `json:"elect"`
    Format string `json:"format"`
    Layout string `json:"layout"`
    Timezone string `json:"timezone"`
}
```

`type` defines the overall parsing type:
1. `auto`: Fully automatic parsing: If you choose auto mode, then try to automatically extract the time from the log line, it is only applicable to simple logs with the timestamp at the beginning of the line, and all other fields do not need to be configured at this time
2. `processTime`: The time when the log is read is used as the timestamp, which has a large uncertainty. At this time, all other fields do not need to be configured
3. `elect`: Extract the timestamp string from the log line, and then parse it into a millisecond-level timestamp. In this case, you need to use the elect/format/layout/timezone field

For the case of `type = elect`:
1. `elect`: used to extract the time string
2. `format`: describes the style of the time string:
   a. `unix`: second-level timestamp
   b. `unixMilli`: millisecond timestamp
   c. `golangLayout`: Its format is described by a Golang-style string, and the Layout field needs to be used at this time
   d. `auto`: A scenario similar to type=auto, it can automatically guess the format and layout of the timestamp
3. `layout`: only used when format = golangLayout, layout is a Golang-style time format
4. `timezone`: time zone, it is not recommended to fill in; it is recommended that the time zone of the log and the container be consistent; if the container time zone resolution is not empty, the container time zone is preferred


## Example
Example 1:
Simple logs:
- 2023-08-04 11:50:05 [main] biz log biz log biz log ... 
- 2023-08-04 11:50:05.123 [main] biz log biz log biz log ...
- 2023-08-04 11:50:05,123 [main] biz log biz log biz log ...
- 2023-08-04T11:50:05 [main] biz log biz log biz log ...
- 2023-08-04 11:50:05 +08:00 [main] biz log biz log biz log ...

> At this time, the time zone of the container will be used to parse the time.

```json
{
   "type": "auto"
}
```

Example 2:
Each line of the user's log is a json string, and the timestamp is in the myTime field. For the time format of myTime, field parsing is used.
- `{"bizField1":"1", "bizField2":"2", "myTime": "2023-08-04 11:50:05"}`

```json
{
   "type": "elect",
   "elect": {
      "type": "refName",
         "refName": {
         "name": "myTime"
      }
   },
   "format": "auto"
}
```

> At this time, the time zone of the container will be used to parse the time.

Example 3:
Each log line of the user is a json string, and the timestamp is in the myTime field. The time format of myTime is parsed in the "2006-01-02 15:04:05" Golang-style time format.
- `{"bizField1":"1", "bizField2":"2", "myTime": "2023-08-04 11:50:05"}`
```
{
   "type": "elect",
   "elect": {
      "type": "refName",
      "refName": {
         "name": "myTime"
      }
   },
   "format": "golangLayout",
   "layout": "2006-01-02 15:04:05"
}
```
> At this time, the time zone of the container will be used to parse the time.

Example 4:
Use processing time as timestamp
```
{
   "type": "processTime"
}
```

# Automatic log time parsing
As mentioned above, HoloInsight-Agent can do some automatic time parsing. In fact, it has built-in support for parsing some common time formats.

When using log monitoring, if no time column is explicitly configured, HoloInsight-Agent will try to automatically parse the time from the log.
But it can only support a few common formats.

The following formats are supported:
- "2006-01-02 15:04:05",
- "2006/01/02 15:04:05",
- "2006-01-02T15:04:05",
- "2006 Jan/02 15:04:05",
- "02/Jan/2006 15:04:05",
- "Jan 02 2006 15:04:05",
- "01/02/2006 15:04:05",

Each format allows a prefix of 4 characters or fewer.
So '[2006-01-02 15:04:05] INFO [main] xxx biz log' can also be parsed normally.

In addition, second-level timestamps and millisecond-level timestamps are also supported, but this requires the timestamp to appear at the beginning of the line, and the length is 10 (second-level timestamp) or 13 (millisecond-level timestamp), and there is no prefix.
For example:
- '1668517987  INFO [main] xxx biz log' can also be parsed normally'
- '1668517987000  INFO [main] xxx biz log' can also be parsed normally'

If your timestamps can't be parsed automatically, then maybe:
1. Timestamp format is not common
2. The position of the timestamp is not at the beginning of the line

At this point, you need to explicitly configure the timestamp parsing method on the page:
![log-timeparse.png](log-timeparse.png)

# Log timezone
When parsing a string to time, the `timezone` is required.
HoloInsight-Agent use the Env `TZ` or `/etc/localtime` of main container of target pod as the timezone to parse time in logs.
> In most cases, a pod contains a business container and sandbox container. The business container is the main container of the pod.
> When a pod contains more than 2 containers (including sandbox container), non-sandbox containers will be divided into biz and sidecar containers.
> At this time, it is required that there is only one business container, otherwise the acquisition target is not unique.
> The judgment method of sidecar container can refer to the code of HoloInsight-Agent: DefaultSidecarCheckHookInstance.

For details, refer to this [article](https://man7.org/linux/man-pages/man5/localtime.5.html).  

The processing sequence is as follows:
1. Check if there is an Env named `TZ` in the container spec, and if so, use it
2. If the `/etc/localtime` of the container is a symbol link, then parse timezone info from the link (such as `/usr/share/zoneinfo/Asia/Shanghai` => `Asia/Shanghai`)
3. If the `/etc/localtime` of the container is a regular file, then parse timezone info and use it

Notice: **timezone info of a container is updated only once in agent's lifecycle**.
Updating `/etc/localtime` after the container starts has no effect on the current agent and is not persistent.

### An extreme error scenario
When the user mounts `/usr/share/zoneinfo/Asia/Shanghai` of the host to `/etc/localtime` of the container, the real result may be:
1. `/etc/localtime` in the container is **still** a symbol link, pointing to `/usr/share/zoneinfo/UTC` or `../usr/share/zoneinfo/UTC`
2. The content of `/usr/share/zoneinfo/UTC` in the container becomes the content of `Asia/Shanghai`.

The reason for this phenomenon is that the **k8s mount action will follow symbol link**.

In order to get correct results, we must read the timezone file once.
In fact, `/usr/share/zoneinfo/UTC` is covered by mount, but it cannot be seen from the mounts information (because there are some symbol links in the middle).
Therefore, the read request must be initiated from inside the container.

Now, while this situation itself is uncommon and problematic, Holoinsight-Agent still parses the time correctly.

### For logs with time zone information
```text
2006-01-02 15:04:05 +08:00 xxx logs ...
```
Currently, HoloInsight-Agent does not take advantage of such timezones in logs.

## How to set timezone in a container
Use one of the following methods to set the time zone of the container. The scheme with the higher serial number is recommended.

1. Add following commands to your Dockerfile:
```dockerfile
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

2. Add Env TZ to your container k8s yaml(TODO required Agent version ?)
```yaml
- name: TZ
  value: Asia/Shanghai
```

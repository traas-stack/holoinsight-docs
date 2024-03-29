# Send Traces to HoloInsight
> Before this you need to [deploy the HoloInsight collector](../../operations/deployment/deploy-holoinsight-collector.md).

Report the trace data to the HoloInsight collector for processing and export to the HoloInsight server, and then you can view the distributed trace links, service topology, and aggregated statistical indicators on the HoloInsight dashboard.

The HoloInsight collector receives trace data based on the [OpenTelemetry](https://opentelemetry.io/) specification, which means that you can use almost any open-source SDK (OTel, SkyWalking, etc.) to collect data and report it uniformly, depending on your software environment and programming language.

# How to configure

> The `YOUR_APPLICATION_NAME` mentioned below is used to identify the `application` (aka the `service`), which should be the same as the application name specified by `-a` when installing HoloInsight Agent.

## Using OTel SDK
> To be added.

## Using SkyWalking Agent
### If your application is deployed in a container
- You can build your image based on the officially recommended [image](https://hub.docker.com/r/apache/skywalking-java-agent) carrying SkyWalking Agent.
```
FROM apache/skywalking-java-agent:8.15.0-java8

ENV SW_AGENT_NAME ${YOUR_APPLICATION_NAME}
ENV SW_AGENT_AUTHENTICATION ${YOUR_HOLOINSIGHT_API_KEY}
ENV SW_AGENT_COLLECTOR_BACKEND_SERVICES ${YOUR_HOLOINSIGHT_COLLECTOR_ADDRESS}

# ... build your java application

# You can start your Java application with `CMD` or `ENTRYPOINT`, 
# but you don't need to care about the Java options to enable SkyWalking agent, 
# it should be adopted automatically.
```

- Or you can manually download the [SkyWalking Agent](https://skywalking.apache.org/downloads/#Agents) and attach it to your application startup command in the Dockerfile.
```
RUN wget https://archive.apache.org/dist/skywalking/java-agent/8.15.0/apache-skywalking-java-agent-8.15.0.tgz
RUN tar zxvf apache-skywalking-java-agent-8.15.0.tgz

ENV SW_AGENT_NAME ${YOUR_APPLICATION_NAME}
ENV SW_AGENT_AUTHENTICATION ${YOUR_HOLOINSIGHT_API_KEY}
ENV SW_AGENT_COLLECTOR_BACKEND_SERVICES ${YOUR_HOLOINSIGHT_COLLECTOR_ADDRESS}

... build your java application

CMD ["java", "-javaagent:PATH/TO/YOUR/SKYWALKING-AGENT/skywalking-agent/agent/skywalking-agent.jar", ${YOUR_APPLICATION_STARTUP_PARAMS}]
```

### If your application is deployed on a host
1. Download and unzip the [SkyWalking Agent](https://skywalking.apache.org/downloads/#Agents)
```
wget https://archive.apache.org/dist/skywalking/java-agent/8.15.0/apache-skywalking-java-agent-8.15.0.tgz
tar zxvf apache-skywalking-java-agent-8.15.0.tgz
```

2. Edit the `skywalking-agent/config/agent.config`
```
agent.service_name=${YOUR_APPLICATION_NAME}
agent.authentication=${YOUR_HOLOINSIGHT_API_KEY}
collector.backend_service=${YOUR_HOLOINSIGHT_COLLECTOR_ADDRESS}
```

3. Enable SkyWalking Agent in the startup command
```
java -javaagent:PATH/TO/YOUR/SKYWALKING-AGENT/skywalking-agent/agent/skywalking-agent.jar ${YOUR_APPLICATION_STARTUP_PARAMS}
```

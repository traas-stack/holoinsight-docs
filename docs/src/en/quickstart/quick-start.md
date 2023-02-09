> This document needs to be used in conjunction with the [Quick Start](https://github.com/traas-stack/holoinsight#quick-start) chapter.  
> The English version of the UI has not been fully translated yet, we are working hard on it.  
> Another option is to use Google translate.  


# Page layout
The left sidecar is a drawer menu bar, the middle is the main content of the page, and the upper right corner is the search bar.
![index](/docs/src/resources/images/quickstart/index-en.png)


# Infrastructure monitoring
This page displays system metrics and metadata for infrastructures (vm, pod, node).
If the vm and pod contains an "app" attribute, it will be used to create the application metadata. (See App monitor)

![infrastructure monitoring](/docs/src/resources/images/quickstart/infrastructure-monitoring-en.png)


# Enable JVM integration
Enables JVM metrics collection for app 'holoinsight-server-example'.

![integration jvm](/docs/src/resources/images/quickstart/integration-jvm-en.png)


# Application monitoring
Application monitoring shows the monitoring data of the application dimension, and now the content mainly includes system metrics and JVM metrics.  

![application monitoring](/docs/src/resources/images/quickstart/application-monitoring-en.png)
![application monitoring server](/docs/src/resources/images/quickstart/application-monitoring-server-en.png)
![application monitoring jvm](/docs/src/resources/images/quickstart/application-monitoring-jvm-en.png)

# Log monitoring
Log monitoring allows the agent to collect logs in vms and pods, and perform local aggregation calculations, and then report the aggregated metrics to the server for display and alarms.

![log monitoring dir](/docs/src/resources/images/quickstart/log-monitoring-en.png)
![log monitoring config 1](/docs/src/resources/images/quickstart/log-monitoring-config-1-en.png)
![log monitoring config 2](/docs/src/resources/images/quickstart/log-monitoring-config-2-en.png)
![log monitoring view](/docs/src/resources/images/quickstart/log-monitoring-view-en.png)

This page displays the raw metrics.

# Dashboard

![dashboard list](/docs/src/resources/images/quickstart/dashboard-en.png)
![dashboard config 1](/docs/src/resources/images/quickstart/dashboard-config-1-en.png)
![dashboard config 2](/docs/src/resources/images/quickstart/dashboard-config-2-en.png)
![dashboard view](/docs/src/resources/images/quickstart/dashboard-view-en.png)


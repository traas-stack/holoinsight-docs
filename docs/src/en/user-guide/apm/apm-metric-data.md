# APM Metric Data
The APM metric data is calculated based on the reported trace details and is used to measure the health status of the application from a statistical point of view. It mainly includes two types of indicators:
- Request quantity: including total amount, failure amount, and success rate.
- Request latency: including average latency and latency quantile.

![img.png](https://github.com/xiangwanpeng/holoinsight-docs/raw/main/docs/src/resources/images/user-guide/apm/service-metric-data.png)

# Data Pre-aggregation
It is inefficient to compute aggregated data from the vast amount of trace details each time. It takes time to respond quickly, especially in scenarios with high real-time requirements(e.g. alert calculation) or long-term queries (e.g. the latency trend of an interface in the past week). 

HoloInsight adopts the pre-aggregation method to aggregate trace details into materialized metric data in advance and write them into the time-series database, improving query performance and timeliness and providing conditions for long-term retention of trend data.
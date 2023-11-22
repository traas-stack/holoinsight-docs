# Summary


# Introduction
- [What is HoloInsight](introduction/what-is-holoinsight.md)
- [Quick Start](introduction/quick-start.md)


# User Guide
- [Application monitoring](user-guide/apm/application-monitoring.md)
  - [Send traces to HoloInsight](user-guide/apm/send-traces-to-holoinsight.md)
  - [Service topology](user-guide/apm/service-topology.md)
  - [APM metric data](user-guide/apm/apm-metric-data.md)
  - [Distributed tracing](user-guide/apm/distributed-tracing.md)
  - [Downstream components](user-guide/apm/downstream-components.md)
- [Log monitoring](user-guide/logmonitor/basic.md)
  - [Create log monitoring](user-guide/logmonitor/create-log-monitor.md)
  - [Key word count](user-guide/logmonitor/key-word-collect.md)
  - [Log folder](user-guide/logmonitor/log-folder.md)
  - [Dim translate](user-guide/logmonitor/dim-translate.md)
  - [Post filtering](user-guide/logmonitor/log-after-filter.md)
  - [Log pattern](user-guide/logmonitor/log-pattern.md)
  - [Log sample](user-guide/logmonitor/log-sample.md)
- [Integrations](user-guide/integrations/base.md)
  - [JVM performance monitor](user-guide/integrations/jvm/jvm-performance-monitor.md)
  - [OpenAIMonitor plugin](user-guide/integrations/openai/openai-monitor.md)
  - [LangChainMonitor plugin](user-guide/integrations/langchain/langchain-monitor.md)
  - [DCGMMonitor plugin](user-guide/integrations/dcgm/dcgm-monitor.md)


# Dev Guide
- [Project structure](dev-guide/project-structure.md)
- [Dev requirements](dev-guide/dev-requirements.md)
  - [Conventional Commit](dev-guide/conventional_commit.md)
  - [Database table structures](dev-guide/database-table-structures.md)
- [Build](dev-guide/build/compile.md)
  - [Compile](dev-guide/build/compile.md)
  - [Build docker image](dev-guide/build/build-docker-image.md)
  - [Docker image details](dev-guide/build/docker-image-details.md)
- [Run](dev-guide/run/README.md)
  - [Server bootstrap configuration](dev-guide/run/server-bootstrap-configuration.md)
  - [Server dynamic configuration](dev-guide/run/server-dynamic-configuration.md)
  - [Agent bootstrap configuration](dev-guide/run/agent-bootstrap-configuration.md)
- [Test](dev-guide/test/README.md)
  - [Test scenes](dev-guide/test/test-scenes.md)
- [Log](dev-guide/log/README.md)
- [Front](dev-guide/front/README.md)
  - [Build](dev-guide/front/build.md)
  - [Run](dev-guide/front/run.md)
- [Internals](dev-guide/internals/README.md)
  - [Log multiline](dev-guide/internals/log-multiline.md)
  - [GPU](dev-guide/internals/gpu.md)
  - [Anomaly detection_algorithm](dev-guide/internals/anomaly-detection-algorithm.md)
  - [Dialcheck](dev-guide/internals/dialcheck.md)
  - [Log timeparse](dev-guide/internals/log-timeparse.md)
  - [Log charset](dev-guide/internals/log-charset.md)
  - [Lossless restart and deploy](dev-guide/internals/lossless-restart-and-deploy.md)

# Operations
- [Deployment](operations/deployment/k8s.md)
  - [K8s](operations/deployment/k8s.md)
  - [Helm charts](operations/deployment/k8s-helm-charts.md)
  - [Deploy HoloInsight collector](operations/deployment/deploy-holoinsight-collector.md)


# Technical and Design
- [Server architecture]()
- [Deployment architecture]()

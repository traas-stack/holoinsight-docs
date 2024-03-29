# Server bootstrap configuration
The server is a Spring Boot app. It manages bootstrap parameters using `config/application.yaml`.
> Check [Externalized Configuration](https://docs.spring.io/spring-boot/docs/2.7.9/reference/html/features.html#features.external-config) in Spring Boot document.  
> You can use all the methods mentioned in the Spring Boot document to modify the configuration.

Here is a simple `application.yaml` with notes.
```yaml
spring:
  application:
    name: holoinsight
  datasource:
    url: jdbc:mysql://127.0.0.1:3306/holoinsight?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&rewriteBatchedStatements=true&socketTimeout=15000&connectTimeout=3000&useTimezone=true&serverTimezone=Asia/Shanghai
    username: holoinsight
    password: holoinsight
    driver-class-name: com.mysql.cj.jdbc.Driver
  data:
    mongodb:
      # We use mongodb as metadata storage
      uri: mongodb://holoinsight:holoinsight@127.0.0.1:27017/holoinsight?keepAlive=true&maxIdleTimeMS=1500000&maxWaitTime=120000&connectTimeout=10000&socketTimeout=10000&socketKeepAlive=true&retryWrites=true
  jackson:
    # This project was first written by Chinese people, so here are some hard codes It will be removed later
    time-zone: Asia/Shanghai
    date-format: yyyy-MM-dd HH:mm:ss

mybatis-plus:
  config-location: classpath:mybatis/mybatis-config.xml
  mapper-locations:
  - classpath*:sqlmap/*.xml
  - classpath*:sqlmap-ext/*.xml

server:
  compression:
    enabled: true

grpc:
  server:
    port: 9091
  client:
    traceExporterService:
      address: static://127.0.0.1:12801
      negotiationType: PLAINTEXT
    queryService:
      address: static://127.0.0.1:9090
      negotiationType: PLAINTEXT

holoinsight:
  roles:
    # This configuration determines which components are activated
    active: gateway,registry,query,meta,home
  storage:
    elasticsearch:
      enable: true
      hosts: 127.0.0.1
    grpcserver:
      enabled: false
  home:
    domain: http://localhost:8080/
    environment:
      env: dev
      deploymentSite: dev
    role: prod
  alert:
    env: dev
    algorithm:
      url: http://127.0.0.1:5005
  query:
    apm:
      address: http://127.0.0.1:8080
  meta:
    domain: 127.0.0.1
    db_data_mode: mongodb
    mongodb_config:
      key-need-convert: false
  registry:
    meta:
      vip: 127.0.0.1
    domain: 127.0.0.1

management:
  # avoid exposing to public
  server:
    port: 8089
    address: 127.0.0.1
  endpoints:
    web:
      base-path: /internal/api/actuator
      exposure:
        include: prometheus,health
  endpoint:
    health:
      show-details: always

crypto:
  client:
    key: abcdefgh-abcd-abcd-abcd-abcdefghijkl

ceresdb:
  host: foo
  port: 5001
  accessUser: foo
  accessToken: foo
```

TODO It is necessary to continue to add notes.

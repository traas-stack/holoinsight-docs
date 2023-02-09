# 页面布局
左侧是抽屉式菜单栏，中间是页面主要内容，右上角是搜索栏。

![首页](/docs/src/resources/images/quickstart/index-cn.png)


# 基础设施监控
基础设施展示了基础资源（vm、pod、node）的系统指标以及元数据。  
基础资源的 vm 和 pod 如果具备 "app" 属性，则它会被用于创建应用元数据。  

![基础设施监控](/docs/src/resources/images/quickstart/infrastucture-monitoring-cn.png)


# 启动 JVM 组件
为 holoinsight-server-example 启动 JVM 指标采集功能。
![集成插件](/docs/src/resources/images/quickstart/integration-jvm-cn.png)


# 应用监控
应用监控展示了应用维度的监控数据，现在内容主要包含系统指控和JVM指标。
![应用监控](/docs/src/resources/images/quickstart/application-monitoring-cn.png)
![应用监控-单机](/docs/src/resources/images/quickstart/application-monitoring-server-cn.png)
![应用监控-jvm](/docs/src/resources/images/quickstart/application-monitoring-jvm-cn.png)


# 日志监控
日志监控可以让 agent 采集 vm、pod 的日志并进行本地聚合计算（发生在 agent 侧），再将聚合后的 metrics 上报到服务端，用于页面展示和告警。

新建日志监控的步骤：
1. 日志监控 -> 选择合适的目录 -> 新建
2. 配置基本配置
  a. 填写名称 "log count"
  b. 类型筛选选择 "应用"
  c. 元数据筛选选择 "holoinsight-server-example"
  d. 新增日志路径
    ⅰ. 选择 "绝对日志路径"
    ⅱ. 扫描选取, 选择日志路径, 本例中为 "/home/admin/logs/holoinsight-server/common-default.log"
3. 配置日志提取
  a. 点击线上日志的刷新按钮, 加载随机一台服务器的末尾几行日志
  b. 日志分布在多行选择 "否"
  c. 切分方式选择 "左起右至"切分
  d. 用鼠标选中样例日志中代表等级的文字, 在本例中是 "INFO", 点击列配置新增按钮, 列名称为 level, 确定
  e. 用鼠标选中样例日志中代表线程的文字, 在本例中是 "http-nio-8080-exec-5" (), 点击列配置新增按钮, 列名称为 thread, 确定
4. 新增监控指标
  a. 名称填写 "log_count"
  b. 指标定义选择 "日志流量"
  c. 维度依次选择 "level", "thread"
  d. 保存
5. 保存

![日志监控-目录](/docs/src/resources/images/quickstart/log-monitoring-cn.png)
![日志监控-配置1](/docs/src/resources/images/quickstart/log-monitoring-config-1-cn.png)
![日志监控-配置2](/docs/src/resources/images/quickstart/log-monitoring-config-2-cn.png)
![日志监控-预览](/docs/src/resources/images/quickstart/log-monitoring-view-cn.png)

这里展示了最细粒度的数据. 需要到大盘上才能实现聚合功能.


# 大盘

1. 进入仪表盘页
2. 新建
3. 新建面板 -> 新增数据源 -> 日志监控 -> foo -> log count -> 选择刚才创建的指标
4. 聚合方式选sumBy, 分组选择 level, 意味着 "sumBy level tag"
5. 调整图例为 "{{level}}"
6. 面板标题修改为 "log count"
7. 保存面板
8. 退出编辑并保存
9. 重新进入大盘

![大盘-列表](/docs/src/resources/images/quickstart/dashboard-cn.png) 
![大盘-配置](/docs/src/resources/images/quickstart/dashboard-config-1-cn.png) 
![大盘-查看](/docs/src/resources/images/quickstart/dashboard-view-cn.png) 



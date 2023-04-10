# Server logs
The server is a Spring Boot app. So it use `slf4j` as log facade and `log4j2` as log impl.

Here are some important log.

> Because the project has not developed stably, the log format may be modified

## agent.log

## bistream.log

## template.log

## target.log

## agent/up.log
This log file contains the 'up' event of log monitor task.

> This server side logs under directory 'agent/' make it easier for developers to view the status of running log monitor tasks without login in the holoinsight-agent container. 

Example:
```text
2023-04-10 11:29:30,402 tenant=[default] workspace=[default] born_time=[10 11:29:30] event_time=[10 11:29:29] ptype=[log_monitor_up] agent=[1a986276-61f5-4350-b403-c2810f0cf4a1] t_c_key=[line_count2_2] t_c_version=[1680776155870] t_ip=[192.168.0.6] t_key=[line_count2_2/dim2:f23c168fe4b03627754c52f632c547e2] ok=[1] up=[1]
```

It contains the following basic fields:
- tenant
- workspace
- born_time: generate time
- event_time: event time
- ptype: **p**ayload type
- agent: agent id
- t_c_key: **t**ask **c**onfig key
- t_c_version: **t**ask **c**onfig version
- t_ip: **t**ask target ip
- t_key: **t**ask key

It contains the following biz fields:
- ok: ok==1 means data in current period (according to event_time) is complete, otherwise data is incomplete
- up: up==1 means the task is running, it should always be 1 if this log exists 


## agent/stat.log
This log file contains the 'stat' event of log monitor task.

Example:
```text
2023-04-10 11:33:14,389 tenant=[default] workspace=[default] born_time=[10 11:33:14] ptype=[log_monitor_stat] agent=[1a986276-61f5-4350-b403-c2810f0cf4a1] t_c_key=[agent_log_line_count_1] t_c_version=[1680772885502] t_ip=[192.168.0.6] t_key=[agent_log_line_count_1/dim2:f23c168fe4b03627754c52f632c547e2] f_bwhere=[0] f_delay=[0] f_gkeys=[0] f_group=[0] f_ignore=[0] f_logparse=[0] f_timeparse=[0] f_where=[0] in_broken=[0] in_bytes=[1957] in_groups=[13] in_io_error=[0] in_lines=[13] in_miss=[0] in_processed=[13] in_skip=[0] out_emit=[1] out_error=[0]
```

It contains same basic fields as `agent/up.log`.

It contains the following biz fields:
- in_io_error: file read error count
- in_miss: in_miss==1 means target file doesn't exist
- in_bytes: the bytes of logs ingested
- in_lines: the lines of logs ingested
- in_groups: the line groups of logs ingested ( see [log-multiline](../internals/log-multiline.md) )
- in_skip: in_skip==1 means there is some problem leading to file offset skipping (such as the log file is truncated by other processes when read)
- in_broken: in_broken==1 means it is broken when reading from file (currently a line with very long length will cause this problem)
- f_bwhere: the number of rows filtered out because of 'BeforeParseWhere' 
- f_ignore: the number of lines filtered out because of 'well known useless logs' (currently Java exception stack logs when use single-line mode)
- f_logparse: the number of groups filtered out because of 'log parse error'
- f_timeparse: the number of groups filtered out because of 'timestamp parse error'
- f_where: the number of groups filtered out because of 'where error' or 'fail to pass where test'
- f_group: the number of groups filtered out because of 'group' stage
- f_gkeys: the number of groups filtered out because of 'groups exceed the groupMaxKeys limit'
- f_delay: the number of groups filtered out because of 'group' stage
- in_processed: the number of processed groups
- out_emit: emit count
- out_error: emit error count

## agent/digest.log
This log file contains the 'digest' event of log monitor task.

The content contained in the current file is relatively complicated. It contains much important information of Agent and log monitor tasks.
Currently, it contains the following events:
- agent bootstrap event
- log consumer start event
- log consumer stop event
- log consumer update event

# Agent logs

# How to use it
Deploy the algorithm service and invoke the interface

POST   http://ai:5000/anomaly_detect
# InPut
| Parameter       | Subparameter        | Data type        | Required | Remarks                                                         |
|:----------------|---------------------|:-----------------|:---------|:----------------------------------------------------------------|
| traceId         |                     | String           | TRUE     | traceId                                                         |
| intervalTime    |                     | Long             | TRUE     | Timing data interval time (ms)                                  |
| detectTime      |                     | Long             | TRUE     | Detection time, whole minutes                                   |
| inputTimeSeries |                     | Dict[int, float] | TRUE     | Input time sequence data {k1: v1,  k2:v2}                       |
| algorithmConfig | sensitivity         | String           | TRUE     | Algorithm sensitivity，high/mid/low                              |
|                 | detectType          | String           | TRUE     | Detection type: up/down/fallZero                                |
| ruleConfig      | defaultDuration     | Int              | FALSE    | Duration of an alarm. The default value is 2                    |
|                 | customUpThreshold   | float            | FALSE    | Upper limit alarm                                               |
|                 | customDownThreshold | float            | FALSE    | Lower limit alarm                                               |
|                 | customChangeRate    | float            | FALSE    | If the change rate exceeds the threshold, an alarm is generated |
# OutPut
| Parameter    | Data type | Remarks                                   |
|--------------|:---------:|-------------------------------------------|
| traceId      |  String   | traceId                                   |
| isSuccessful |   bool    | Task execution or not：True/False          |
| errorCode    |    int    | Error code                                |
| detectTime   |   Long    | Detection time                            |
| isException  |   bool    | Check whether data is abnormal：True/False |
# FOR EXAMPLE
##Example For Value Rise Detect
###InPut
```json
{
  "inputTimeSeries": {
    "1681710540000": 559,
    "1681710600000": 597,
    "1681710660000": 505,
    "1681710720000": 572,
    "1681710780000": 515,
    "1681710840000": 552,
    "1681710900000": 549,
    "1681710960000": 521,
    "1681711020000": 500,
    "1681711080000": 564,
    "1681711140000": 517,
    "1681711200000": 5000
  },
    "intervalTime": 60000,
    "detectTime": 1681711200000,
    "algorithmConfig": {
    "algorithmType": "up",
    "sensitivity": "mid"
  },
    "ruleConfig": {
    "defaultDuration": 1,
    "customChangeRate": 0.1
  }
}
```
###OutPut
```json
{
  "detectTime": 1681711200000,
  "errorCode": {},
  "isException": true,
  "isSuccessful": true,
  "traceId": null
}
```
##Example For Value Fall Detect
###InPut
```json
{
  "inputTimeSeries": {
    "1681710540000": 459,
    "1681710600000": 497,
    "1681710660000": 405,
    "1681710720000": 482,
    "1681710780000": 435,
    "1681710840000": 452,
    "1681710900000": 445,
    "1681710960000": 421,
    "1681711020000": 400,
    "1681711080000": 445,
    "1681711140000": 417,
    "1681711200000": 1
  },
    "intervalTime": 60000,
    "detectTime": 1681711200000,
    "algorithmConfig": {
    "algorithmType": "down",
    "sensitivity": "mid"
  },
    "ruleConfig": {
    "defaultDuration": 1,
    "customChangeRate": 0.1
  }
}
```
###OutPut
```json
{
  "detectTime": 1681711200000,
  "errorCode": {},
  "isException": true,
  "isSuccessful": true,
  "traceId": null
}
```
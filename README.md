[![Docker](https://badgen.net/badge/icon/senmicloud%2fjmeter-influxdb?icon=docker&label)](https://hub.docker.com/r/senmicloud/jmeter-influxdb)

<img src="https://avatars.githubusercontent.com/u/54386046?v=4" width="200"/>

# jmeter-influxdb
- ## Docker image of JMeter v5.5 w/ InfluxDB plugin v2.5
- ## openjdk17-alpine

<br>

### Mount your jmx plan(with `InfluxDB Backend Listener`)
<br>

## Example 1
```
apiVersion: batch/v1
kind: Job
metadata:
    name: sc-job-jmeter
    namespace: sc-devops
    labels:
        app: sc-job-jmeter
spec:
    ttlSecondsAfterFinished: 5
    backoffLimit: 5
    parallelism: 1
    template:
        metadata:
            labels:
                app: sc-job-jmeter
        spec:
            volumes:
            - name: configs
                hostPath:
                    path: /mnt/configs
            - name: log
              hostPath:
                    path: /mnt/log
            containers:
            - name: sc-job-jmeter
              image: senmicloud/jmeter-influxdb

              volumeMounts:
                - name: configs
                  mountPath: /jmeter
                  subPath: sc-job-jmeter

                - name: log
                  mountPath: /log
                  subPath: sc-job-jmeter
```
## Example 2
```
apiVersion: batch/v1
kind: Job
metadata:
    name: sc-job-jmeter
    namespace: sc-devops
    labels:
        app: sc-job-jmeter
spec:
    ttlSecondsAfterFinished: 5
    backoffLimit: 5
    parallelism: 1
    template:
        metadata:
            labels:
                app: sc-job-jmeter
        spec:
            volumes:
            - name: configs
                hostPath:
                    path: /mnt/configs
            - name: log
              hostPath:
                    path: /mnt/log
            containers:
            - name: sc-job-jmeter
              image: senmicloud/jmeter-influxdb

              command: [ "sh", "-c"]
              args:
                - |
                  rm -rf /jmeter/result/*

                  jmeter -n -Dlog4j2.formatMsgNoLookups=true -t /jmeter/plan/load-test-plan-with-influxdb-backend-listener.jmx -l /jmeter/result/load-test-result.jtl -e -o /jmeter/result -j /log/sc-job-jmeter.log

              volumeMounts:
                - name: configs
                  mountPath: /jmeter
                  subPath: sc-job-jmeter

                - name: log
                  mountPath: /log
                  subPath: sc-job-jmeter
```
---
## Volumes to mount
```
├─ /mnt/configs/
│  ├─ sc-job-jmeter
│  │  ├─ plan
│  │  │  └─  load-test-plan-with-influxdb-backend-listener.jmx
│  │  └─ result
```
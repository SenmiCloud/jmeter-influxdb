    sudo buildctl build \
        --frontend=dockerfile.v0 \
        --local context=. \
        --local dockerfile=. \
        --export-cache type=local,dest=/tmp/buildctl-cache/jmeter-influxdb \
        --import-cache type=local,src=/tmp/buildctl-cache/jmeter-influxdb \
        --output type=image,name=docker.io/senmicloud/jmeter-influxdb:latest,unpack=true
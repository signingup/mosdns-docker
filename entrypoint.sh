#!/bin/sh
crond
mosdns service install -d /etc/mosdns -c config.yaml
mosdns start --as-service -d /etc/mosdns -c config.yaml

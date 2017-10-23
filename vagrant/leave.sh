#!/bin/bash

UPSTREAM_FILE=/usr/nginx/conf/upstreams.conf
while read line; do
    ip=$(echo $line | cut -d " " -f 2 )
    grep $ip $UPSTREAM_FILE > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        sed -i '/\ \ \ \ server '$ip':8080;/d' $UPSTREAM_FILE
        sudo systemctl reload nginx
    fi
done


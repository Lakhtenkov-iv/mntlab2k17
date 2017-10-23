#!/bin/bash

UPSTREAM_FILE=/usr/nginx/conf/upstreams.conf
while read line; do
    ip=$(echo $line | cut -d " " -f 2)
    role=$(echo $line | cut -d " " -f 3)
    grep $ip $UPSTREAM_FILE > /dev/null 2>&1
    if [[ $? -eq 1  &&  $role == "appserv" ]]; then
        sed -i '/upstream backend {/a \ \ \ \ server '$ip':8080;' $UPSTREAM_FILE
        sudo systemctl reload nginx
    fi
done


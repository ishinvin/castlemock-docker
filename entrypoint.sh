#!/usr/bin/env bash

wait_for_server() {
    local url="$1"
    local max_attempts="$2"
    local interval="$3"
    
    for i in $(seq 1 "$max_attempts"); do
        if curl -s -o /dev/null -w "%{http_code}" "$url" | grep -q "200"; then
            return 0
        fi
        sleep "$interval"
    done
    
    return 1
}

import_projects() {
    if wait_for_server "http://localhost:8080/castlemock/web" 36 5; then
    
        for file in /usr/local/tomcat/projects/rest/*; do
            curl -s -o /dev/null -X POST "http://localhost:8080/castlemock/api/rest/core/project/REST/import" \
                -H "accept: */*" \
                -H "Authorization: Basic YWRtaW46YWRtaW4=" \
                -H "Content-Type: multipart/form-data" \
                -F "file=@/usr/local/tomcat/projects/rest/${file##*/}"
        done

        for file in /usr/local/tomcat/projects/soap/*; do
            curl -s -o /dev/null -X POST "http://localhost:8080/castlemock/api/rest/core/project/SOAP/import" \
                -H "accept: */*" \
                -H "Authorization: Basic YWRtaW46YWRtaW4=" \
                -H "Content-Type: multipart/form-data" \
                -F "file=@/usr/local/tomcat/projects/soap/${file##*/}"
        done
    else
        false
    fi
}

import_projects &
catalina.sh run



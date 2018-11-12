#!/usr/bin/env bash

INDEX='company-search-aslive-v3'
SETTINGS_FILE='index-settings.json'

echo "Deleting $INDEX"

http_code=`curl -s -o /dev/null -w "%{http_code}" -XDELETE http://localhost:9200/$INDEX`

echo "Creating $INDEX"

curl -XPUT -H'Content-Type: application/json' -d@"$SETTINGS_FILE" "http://localhost:9200/$INDEX"

echo "Checking setting of $INDEX"

curl -XGET -H'Content-Type: application/json' -d@"$SETTINGS_FILE" "http://localhost:9200/$INDEX/_settings"

echo "Checking mapping of $INDEX"

curl -XGET -H'Content-Type: application/json' -d@"$SETTINGS_FILE" "http://localhost:9200/$INDEX/_mapping"

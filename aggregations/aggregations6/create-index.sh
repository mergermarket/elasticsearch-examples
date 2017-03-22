#!/usr/bin/env bash

INDEX='my-first-index'
SETTINGS_FILE='index-settings.json'

echo "Deleting $INDEX"

http_code=`curl -s -o /dev/null -w "%{http_code}" -XDELETE http://localhost:9200/$INDEX`

echo "Creating $INDEX"

curl -XPUT -d@"$SETTINGS_FILE" "http://localhost:9200/$INDEX"


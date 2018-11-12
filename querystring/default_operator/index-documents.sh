#!/usr/bin/env bash

INDEX='company-search-aslive-v3'
TYPE='company'

for file in `ls document*.json`; do
  id=`echo "$file" | sed "s/\(document[0-9]*\)\.json/\1/"`
  curl -XPUT -H'Content-Type: application/json' -d@"$file" "http://localhost:9200/$INDEX/$TYPE/$id"
done

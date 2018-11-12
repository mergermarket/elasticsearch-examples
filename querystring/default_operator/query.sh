#!/usr/bin/env bash

INDEX='company-search-aslive-v3'
TYPE='atype'

if [ -z "$1" ]
  then
    echo "Usage: $0 <query json file>"
    exit 1
fi

QUERYJSON="$1"

curl -s -XPOST -H'Content-Type: application/json' -d@"$QUERYJSON" "http://localhost:9200/$INDEX/_search?pretty"



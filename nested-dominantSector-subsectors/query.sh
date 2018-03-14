#!/usr/bin/env bash

INDEX='my-first-index'
TYPE='intelligence'

if [ -z "$1" ]
  then
    echo "Usage: $0 <query json file>"
    exit 1
fi

QUERYJSON="$1"

set -x
curl -XPOST -d@"$QUERYJSON" "http://localhost:9200/$INDEX/_search?pretty"



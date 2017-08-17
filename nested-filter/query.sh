#!/usr/bin/env bash

INDEX='my-first-index'
TYPE='intelligence'

set -x
curl -XPOST -d@"query1.json" "http://localhost:9200/$INDEX/_search?pretty"



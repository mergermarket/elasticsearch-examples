#!/usr/bin/env bash

INDEX='my-first-index'
TYPE='intelligence'

set -x
curl -XPOST -d@"$1" "http://localhost:9200/$INDEX/_search?pretty"



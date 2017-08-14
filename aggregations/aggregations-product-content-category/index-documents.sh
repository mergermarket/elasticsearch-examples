#!/usr/bin/env bash

INDEX='my-first-index'
TYPE='atype'

for file in `ls document*.json`; do
  curl -XPOST -d@"$file" "http://localhost:9200/$INDEX/$TYPE/"
done

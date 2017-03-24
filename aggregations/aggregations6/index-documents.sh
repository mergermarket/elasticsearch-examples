#!/usr/bin/env bash

INDEX='my-first-index'
TYPE='atype'

for file in document1.json document2.json; do
  curl -XPOST -d@"$file" "http://localhost:9200/$INDEX/$TYPE/"
done

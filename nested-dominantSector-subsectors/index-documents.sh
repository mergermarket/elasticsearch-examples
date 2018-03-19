#!/usr/bin/env bash

INDEX='my-first-index'
TYPE='intelligence'

for file in document1.json document2.json document3.json document4.json; do
  curl --user elastic:changeme -XPOST -d@"$file" "http://localhost:9200/$INDEX/$TYPE/"
done

# elasticsearch-examples

1. `./create-index.sh` : creates a new empty index

2. `./index-documents.sh` : puts 2 documents into the index: document1.json & document2.json

3. `./query.sh` : executes the query in query1.json  

## aggregations1 

A basic aggregation example.

Given some documents like:

```json
{
  "title" : "A mighty fine document",
  "topics": [
    "vegetables",
    "animals",
    "minerals"
  ]
}
```

We want to execute a query and get back, in addition to the first n hits, a breakdown of the total number of hits in each topic.
ElasticSearch calls this feature 'aggregations'.

An example ElasticSearch query, with "aggs" element indicating we want an aggregation returned:

```json
{
  "query": {
    "term" : { "title" : "mighty" } 
  }
  "aggs": {
    "topics": {
      "terms": {
        "field": "topics.keyword"
      }
    }
  }
}
```

An example response with aggregation:

```
{
  "hits" : {
    "total": 1,
    "hits": [...]
  },
  "aggregations" : {
    "topics" : {
      "doc_count_error_upper_bound" : 0,
      "sum_other_doc_count" : 0,
      "buckets" : [
        {
          "key" : "vegetables",
          "doc_count" : 2
        },
        {
          "key" : "animals",
          "doc_count" : 1
        },
        {
          "key" : "books",
          "doc_count" : 1
        },
        {
          "key" : "minerals",
          "doc_count" : 1
        }
      ]
    }
  }
}
```

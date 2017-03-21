# elasticsearch-examples

1. `./create-index.sh` : creates a new empty index

2. `./index-documents.sh` : puts 2 documents into the index: document1.json & document2.json

3. `./query.sh` : executes the query in query1.json  

## aggregations1 

A basic aggregation example.

Given some documents like:

```
{
  "title" : "A mighty fine document",
  "topics": [
    "vegetables",
    "animals",
    "minerals"
  ]
}
```

We want to do a search and get back the number of hits in each topic.
ElasticSearch calls this feature 'aggregations'.
An example search response with aggregations:

```
{
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

# elasticsearch-examples

## aggregations5

In this example our topics and subtopics are not simple strings but objects with 'id' and 'name':

```json
{
  "topics": [
    {
      "id": "1",
      "name" : "vegetables",
      "subtopics" : [
        { "id": "11", "name": "artichoke" },
        { "id": "12", "name": "asparagus" }
      ]
    }
  ]
}
```

We want to return both the id and name for each bucket: clients use the id for filter queries, the name for display.

Ideally we'd get back both the id and the name with each bucket, something like this:

```json
{
  "aggregations" : {
    "topics" : {
      "buckets" : [
        {
          "key" : "1",
          "name": "vegetables",
          "doc_count" : 2,
          "subtopics" : {
            "buckets" : [
              {
                "key" : "12",
                "name" : "asparagus",
                "doc_count" : 2
              },
              {
                "key" : "11",
                "name" : "artichoke",
                "doc_count" : 1
              },
              {
                "key" : "aubergine",
                "doc_count" : 1
              }
            ]
          }
        }
      ]
    }
  }
}
```

Unfortunately I haven't found a way to do this in ElasticSearch.
 
Our workaround is to create a new field inside each document before we send it to ElasticSearch, with id and name 
concatenated, and then rewrite the ElasticSearch response to separate the id+name before returning to clients.

Example document with "_computed" field added:
```json
{
  "title" : "A mighty fine document",
  "topics": [
    {
      "id": "1",
      "name" : "vegetables",
      "subtopics" : [
        { "id": "11", "name": "artichoke" },
        { "id": "12", "name": "asparagus" }
      ]
    }
  ],
  "_computed" : {
    "topics": [
      {
        "id_name": "1|vegetables",
        "subtopics" : [
          { "id_name": "11|artichoke" },
          { "id_name": "12|asparagus" }
        ]
      }
    ]
  }
}
```

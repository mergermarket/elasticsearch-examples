# elasticsearch-examples

## aggregations3

In this example, the documents have topics and subtopics:

```json
{
  "title" : "A mighty fine document",
  "topics": [
    {
      "name" : "vegetables",
      "subtopics" : [
        { "name": "artichoke" },
        { "name": "asparagus"}
      ]
    },
    {
      "name" : "fruits",
      "subtopics" : [
        { "name": "apple" }
      ]
    }
  ]
}


```
```json
{
  "title" : "Another document",
  "topics": [
    {
      "name" : "vegetables",
      "subtopics" : [
        { "name": "asparagus" },
        { "name": "aubergine" }
      ]
    }
  ]
}
```

When you execute the query, the response should show the correct number of documents for each topic and subtopic.

HOWEVER! The counts are correct, but "apple" shows up under "vegetables", and "artichoke" and "asparagus" appear under "fruits":


```json
{
  "aggregations" : {
    "topics" : {
      "buckets" : [
        {
          "key" : "vegetables",
          "doc_count" : 2,
          "subtopics" : {
            "buckets" : [
              {
                "key" : "asparagus",
                "doc_count" : 2
              },
              {
                "key" : "apple",
                "doc_count" : 1
              },
              {
                "key" : "artichoke",
                "doc_count" : 1
              },
              {
                "key" : "aubergine",
                "doc_count" : 1
              }
            ]
          }
        },
        {
          "key" : "fruits",
          "doc_count" : 1,
          "subtopics" : {
            "buckets" : [
              {
                "key" : "apple",
                "doc_count" : 1
              },
              {
                "key" : "artichoke",
                "doc_count" : 1
              },
              {
                "key" : "asparagus",
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

The solution for this problem is to use "nested" aggregation, shown in aggregations4.

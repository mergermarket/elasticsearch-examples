# elasticsearch-examples

## aggregations4

Building on aggregations3, we fix the problem by: 

1. in index-settings.json, we define 'mappings', and indicate that the field 'topics' is 'nested'

2. in query1.json, we indicate that the 'topics' aggregation is 'nested' instead of 'terms'

```json
{
  "size": 0,
  "aggs": {
    "topics": {
      "nested": {
        "path": "topics"
      },
      "aggs": {
        "topics": {
          "terms": {
            "field": "topics.name"
          },
          "aggs": {
            "subtopics": {
              "terms": {
                "field": "topics.subtopics.name"
              }
            }
          }
        }
      }
    }
  }
}
```
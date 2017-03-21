# elasticsearch-examples

## aggregations2

Same as aggregations1, except: 
 
 1. in index-settings.json, we declare that the 'topics' field is of type 'keyword'
 2. in query1.json, in the 'aggs' section we say `"field": "topics"` instead of `"field": "topics.keyword"`
 
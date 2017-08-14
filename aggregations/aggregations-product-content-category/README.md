# elasticsearch-examples

1. `./create-index.sh` : creates a new empty index

2. `./index-documents.sh` : puts 2 documents into the index: document1.json & document2.json

3. `./query.sh` : executes the query in query1.json  

## aggregations-product-content-category


Given some documents like:

```json
{
  "title" : "A mighty fine document",
  "productAttributes": { 
    "debtwire": {
      "contentCategories": [ "research" ] 
    }
  }
}
```

We want to get number of hits for every value of "debtwire.contentCategories".


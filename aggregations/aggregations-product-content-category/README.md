# elasticsearch-examples

1. `./create-index.sh` : creates a new empty index

2. `./index-documents.sh` : puts `document*.json` into the index

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


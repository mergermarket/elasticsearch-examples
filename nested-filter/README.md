# elasticsearch-examples

1. `./create-index.sh` : creates a new empty index

2. `./index-documents.sh` : puts 2 documents into the index: document1.json & document2.json

3. `./query.sh query1.json` : executes the query in query1.json  

## nested-filter 

A query with a filter on a nested property.

Given some documents like:

```json
{
  "title": "doc one",
  "_computed": {
    "allCompanies": [
      {
        "mmgid": "prime-15",
        "roles": [
          "others"
        ],
        "name": "Goldman Sachs",
        "id_name": "prime-15<-id_name->Goldman Sachs"
      }
    ]
  },
  "status": "final"
}
```

We want to do a search on some text fields, and filter on particular values for '_computed.allCompanies.mmgid'.

Our index has '_computed.allCompanies' property configured as 'nested' - see [./index-settings.json](index-settings.json)

That nested business means we have to use a different kind of filter query. 


```json
{
  "query": {
    "bool": {
      "must": [
        {
          "query_string": {
            "query": "doc",
            "default_operator": "and"
          }
        }
      ],
      "filter": {
        "bool": {
          "must": [
            {
              "terms": {
                "status": [
                  "final"
                ]
              }
            },
            {
              "nested": {
                "path": "_computed.allCompanies",
                "query": {
                  "bool": {
                    "must": [
                      {
                        "match": {
                          "_computed.allCompanies.mmgid": "prime-15"
                        }
                      }
                    ]
                  }
                }
              }
            }
          ]
        }
      }
    }
  }
}
```


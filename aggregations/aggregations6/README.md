# elasticsearch-examples

## aggregations6

In this example we want to do a nested aggregation, but starting from somewhere in the hierarchy other than the base.

Our hierarchy:

1. areas (e.g., Europe)
    1.  regions (e.g., ,Western Europe)
        1. countries
            1. states
            
our query:

```json
{
  "size": 0,
  "aggs": {
    "regions": {
      "nested": {
        "path": "_computed.areas.regions"
      },
      "aggs": {
        "regions": {
          "terms": {
            "field": "_computed.areas.regions.id_name"
          },
          "aggs": {
            "countries": {
              "terms": {
                "field": "_computed.areas.regions.countries"
              }
            }
          }
        }
      }
    }
  }
}

```
        
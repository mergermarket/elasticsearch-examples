# elasticsearch-examples

1. `./create-index.sh` : creates a new empty index

2. `./index-documents.sh` : puts 2 documents into the index: document1.json & document2.json

3. `./query.sh query1.json` : executes the query in query1.json  

## nested-filter 

A nested aggregation with filter.

Given some documents like:

```json
{
  "title": "doc one",
  "_computed": {
    "sectors": [
      {
        "id_name": "prime-chemicalmat<-id_name->Chemicals and materials",
        "isdominant": "true",
        "subsectors": [
          "prime-agrochem<-id_name->Agrochemicals",
          "prime-commoditychem<-id_name->Commodity chemicals (non-petrochemical)",
          "prime-constructionchem<-id_name->Construction chemicals",
          "prime-cosmeticcarechem<-id_name->Cosmetic/care chemicals",
          "prime-finechemother<-id_name->Fine chemicals- other",
          "prime-finechempharm<-id_name->Fine chemicals- pharmaceuticals",
          "prime-flavourfragrance<-id_name->Flavours and fragrances",
          "prime-foodadditives<-id_name->Food additives/ ingredients",
          "prime-indgases<-id_name->Industrial gases",
          "prime-inorganicchem<-id_name->Inorganic chemicals",
          "prime-paintchem<-id_name->Paints and chemicals",
          "prime-perrochemderiv<-id_name->Petrochemicals- derivatives",
          "prime-petrochembase<-id_name->Petrochemicals- base",
          "prime-speciality<-id_name->Speciality-other",
          "prime-specialityinter<-id_name->Specialities - intermediates"
        ]
      },
      {
        "subsectors": [
          "prime-apparel<-id_name->Apparel",
          "prime-buildingmaterial<-id_name->Building materials/DIY/Garden",
          "prime-chemists<-id_name->Chemists/health",
          "prime-deptstores<-id_name->Department stores",
          "prime-electricalapp<-id_name->Electrical appliances",
          "prime-furniture<-id_name->Furniture",
          "prime-lifestyle<-id_name->Lifestyle including sports/music/books etc",
          "prime-retailother<-id_name->Other retailing of consumer products and services",
          "prime-supermarkets<-id_name->Supermarkets (food chains)",
          "prime-vehicles<-id_name->Vehicles"
        ],
        "isdominant": "false",
        "id_name": "prime-consumerretail<-id_name->Consumer: Retail"
      }
    ]
  },
  "status": "final"
}
```

We want to do a search on some text fields, and group by particular field '_computed.sectors.isdominant' and return its subsectors

Our index has '_computed.sectors' property configured as 'nested' - see [./index-settings.json](index-settings.json)

That nested business means we have to use a different kind of aggregation and filter aggregation query.


```json
{

  "size": 2,
  "aggs": {
    "sectors": {
      "nested" : {
        "path" : "_computed.sectors"
      },
      "aggs":{
        "dominantSectors":{
          "filter" : { "term": { "_computed.sectors.isdominant": "true" } },
          "aggs":{
            "dominantSector":{
              "terms": {
                "field": "_computed.sectors.id_name"
              },
              "aggs":{
                "dominantSectorSubSectors":{
                  "terms": {
                    "field": "_computed.sectors.subsectors"
                  }
                }
              }
            }

          }
        }
      }


    }
  }
}

```


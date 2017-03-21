# elasticsearch-examples

All the examples in this repository use an instance of ElasticSearch running on localhost:9200.
If you have docker-compose installed you can execute:
```bash
./docker-compose up -d
```
Each folder in this repository has a few bash scripts and json files that demonstrate various ElasticSearch features.

To exercise any of the examples, cd into the folder and do the following:

1. Create and configure an empty index: `./create-index.sh`

2. Add the example documents to the index: `./index-documents.sh`

3. Run a search. `./query.sh`


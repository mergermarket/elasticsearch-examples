# querystring1

This example explores the behavior of ElasticSearch's ["query_string" feature](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html).
 
1. `./create-index.sh` : creates a new empty index

2. `./index-documents.sh` : puts documents into the index: document*.json

3. `./query.sh <query json file>` : executes the query in the specified file  

## the queries

### query1.json 

```json
{
  "query": {
    "query_string" : {
      "query" : "\"london stock exchange\" OR pizza situation"
    }
  }
}
```

#### default default_operator

Note the ambiguity: without an "AND" or "OR" between "pizza" and "situation", what does it mean?

How does ElasticSearch query_string parser interpret this query?

"query_string accepts an option "default_operator" which determines what to stick in between "pizza" and "situation." The default value of "default_operator" is "OR".

Therefore the above query is equivalent to `"london stock exchange" OR pizza OR situation"`.

In other words it matches documents that contain:

    - at least one of:  
        - the exact phrase "london stock exchange"
        - the single word "pizza"
        - the single word "situation"

It returns 7 matches:


| document  | matches query1  | "london stock exchange"  | pizza  | situation  |
|---|---|---|---|---|
| document1.json  | YES  | YES  | YES  | YES  |
| document2.json   |  YES | YES  |YES   | NO  |
| document3.json   |  YES | YES  |  NO | YES  |
| document4.json   |  YES | NO  |  YES | YES  |
| document5.json   |  YES | YES  |  NO | NO |
| document6.json   |  YES | NO  |  YES | NO |
| document7.json   |  YES | NO  |  NO | YES |
| document8.json   |  NO | NO  |  NO | NO |

### query2.json 

```json
{
  "query": {
    "query_string" : {
      "query" : "\"london stock exchange\" OR (pizza AND situation)"
    }
  }
}
```

Query2 is unambiguous. It matches documents that contain:

    - either:  
        - the exact phrase "london stock exchange"
    - or:
        - both:
            - the single word "pizza"
            - the single word "situation"

It returns 5 matches:

| document  | matches query2  | "london stock exchange"  | pizza  | situation  |
|---|---|---|---|---|
| document1.json | YES | YES  | YES  | YES  |
| document2.json | YES | YES  |YES   | NO  |
| document3.json | YES | YES  |  NO | YES  |
| document4.json | YES | NO  |  YES | YES  |
| document5.json | YES | YES  |  NO | NO |
| document6.json | NO  | NO  |  YES | NO |
| document7.json | NO  | NO  |  NO | YES |
| document8.json | NO  | NO  |  NO | NO |

### query3.json 

```json
{
  "query": {
    "query_string" : {
      "default_operator" : "AND",
      "query" : "\"london stock exchange\" OR pizza situation"
    }
  }
}
```

Query3 has a different kind of ambiguity.

We're explicitly declaring that the default_operator is "AND", so we know it's equivalent to:

```"london stock exchange" OR pizza AND situation```

But what does that mean?

It might mean option 1:

```("london stock exchange" OR pizza) AND situation```

or option 2:

```"london stock exchange" OR (pizza AND situation)```

It returns 4 matches:

| document  | matches query2  | "london stock exchange"  | pizza  | situation  |
|---|---|---|---|---|
| document1.json | YES | YES | YES | YES |
| document2.json | NO  | YES | YES | NO  |
| document3.json | YES | YES |  NO | YES |
| document4.json | YES | NO  | YES | YES |
| document5.json | NO  | YES | NO  | NO  |
| document6.json | NO  | NO  | YES | NO  |
| document7.json | YES | NO  | NO  | YES |
| document8.json | NO  | NO  | NO  | NO  |


# Common Directory

A directory is an index with some data. Its structure is very simple:

```
{
    "description":"01111 - GROWING OF LEAFY AND FRUIT VEGETABLES",
    "id":230189
}
```

### id

The unique ID of the record.

### description

The human-readable description for the record: INDUSTRY_CODES, OCCUPATION_CODES, CORPORATE_TYPES
There are several types of common directories:

Each of them can be obtained with use of the following endpoint:

```bash
curl -x GET -H "Authorization: Bearer $TOKEN"  $API_HOST/api/v1/directory/$DIRECTORY_CODE
```

The values for $DIRECTORY_CODE are: INDUSTRY_CODES, OCCUPATION_CODES, CORPORATE_TYPES.

#### Response Example

For Singaporean providers, the CORPORATE_TYPES directory returns something like this:

```json
[
  ....
  {
    "description": "PBL - LOCAL PUBLIC COMPANY (PBL)" ,
    "id": ... ,
    "business_code": "PBL" ,
    "type": "CORPORATE_TYPES" ,
    "country": {
      "value": "SG"
    }
  } ,
  {
    "description": "PTE - LOCAL PRIVATE COMPANY (PTE)" ,
    "id": ... ,
    "business_code": "PTE" ,
    "type": "CORPORATE_TYPES" ,
    "country": {
      "value": "SG"
    }
  }
  ....
]
```

# Business Category

Business categories is a directory for the high level of classification of businesses. It has Singaporean
origins but is suitable for most other countries.

```json
{
  "code": "K" ,
  "description": "Financial And Insurance Activities" ,
  "value": 11
}
```

It is always used in conjunction with Business sub-category:

```json
{
  "code": "649" ,
  "description": "Other Financial Services Activities, Except Insurance And Pension Funding Activities" ,
  "value": 141
}
```

The following endpoint must be used for obtaining business categories:

```bash
curl -x GET -H "Authorization: Bearer $TOKEN"  $API_HOST/api/v1/businesscategories
```

#### Example Reponse

```json
[
  {
    "code": "A" ,
    "description": "Agriculture And Fishing" ,
    "value": 1 ,
    "sub_categories": [
      {
        "code": "011" ,
        "description": "Growing Of Crops, Market Gardening And Horticulture" ,
        "value": 1
      } ,
      {
        "code": "014" ,
        "description": "Animal Production" ,
        "value": 2
      }
    ]
  } ,
  {
    "code": "B" ,
    "description": "Mining And Quarrying" ,
    "value": 2 ,
    "sub_categories": [
      {
        "code": "081" ,
        "description": "Quarrying Of Stone, Sand And Clay" ,
        "value": 3
      } ,
      {
        "code": "089" ,
        "description": "Other Mining And Quarrying" ,
        "value": 4
      }
    ]
  }
]
```

### code

The public code.

### description

The human-readable description.

### value

The value in the system's database.

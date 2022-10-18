# Gender Model

The directory has the structure:

```json
[
  {
    "description": "Male" ,
    "value": "Male"
  } ,
  {
    "description": "Female" ,
    "value": "Female"
  }
]
```

The values can be obtained with use of this endpoint:

```bash
curl -x GET -H "Authorization: Bearer $TOKEN"  $API_HOST/api/v1/genders
```

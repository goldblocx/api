# Retrieving list of currencies for transaction
Returns a list of available currencies for each transaction type
This function allows to retrieve a list of all currencies which are available for a required external transaction. This list of currencies can be specific for each transaction type.
### REQUEST:
       GET     /api/v1/currencies/:type
### ARGUMENTS:
       type = 'fromcard", "tocard" or "toaccount"
### EXAMPLE:
```bash
TOKEN="your access token here"
curl -X GET -H "Accept: application/json" -H -H "Authorization: Bearer $TOKEN" https://api.projectdgc.com/api/v1/currencies/fromcard
```
### RESPONSE:
```javascript
[
    {"description": "USD", "value": "USD"},
    {"description": "EUR", "value": "EUR"},
]
```
The specified values should be used as the related_currency attribute in aforementioned transaction models.

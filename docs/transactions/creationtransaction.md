# Creation of new transaction
Creates a new transaction
Creates a new transaction from JSON model of its fields. The current implementation uses the common account type as a source account for this transaction. Make sure that you specified the Content-Type header as "application/json".

### REQUEST:
       POST     /api/v1/transactions
### ARGUMENTS:
       request body - { "amount" : "...", "details" : "...", "contact_type" : "...", "contact" : "..." }
### EXAMPLE:
```bash
TOKEN="your access token here"
curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d '{"amount":"5.003","details":"Invoce # 2433","contact_type" : "Phone","contact":"79122437136"}' https://testapi.copernicusgold.com/api/v1/transactions
```

### RESPONSE:
```javascript
{
  "created":"2015-05-13T12:19:17.512+0000",
  "id":4851, 
  "details":"Invoce # 2433",
  "amount": 5.003,
  "account": { 
              "description":"Current",
              "id":4750,
              "type":"Common"
              },
  "contact":"79122437136", 
  "contact_type":"Phone",
  "state":"New", 
  "direction":0
}
```
The fields in the provided transaction model are the same as for lists of transactions (see above).

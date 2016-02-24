# Editing of a transaction
Changes transaction fields and state
This method allows to change transaction fields (if it is in **Draft** or **New** state) or changes state of a transaction. Mostly the fields are the same as in the case of creation a transaction with one exception: there is an obligate field 'id' which identifies the transaction to modify. Modification of the transaction works for 'New' and 'Draft' states of the transaction. If the transaction has other states, the mofication will resulted as the following error {"code" : "-1", "message" : "Transaction state is invalid"}.
### REQUEST:
       PUT     /api/v1/transactions
### ARGUMENTS:
       request body - { "id", "...",  "amount" : "...", "details" : "...", "contact_type" : "...", "contact" : "..." }. id - obligate field
### EXAMPLE:
```bash
TOKEN="your access token here"
curl -X PUT -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d '{"id" : "3455", "amount":"5.003","details":"Invoce # 2433","contact_type" : "Phone","contact":"79122437136"}' https://testapi.copernicusgold.com/api/v1/transactions
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
  "state":"Draft", 
  "direction":0,
  "modified": "2015-05-13T14:36:53.280+0000"
}
```
The fields in the provided transaction model are the same as for lists of transactions (see above). Each modification sets the currenct state of a transaction to be '**Draft**'.

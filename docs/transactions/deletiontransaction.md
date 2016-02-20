# Deletion a transaction
Deletes a transaction without ability to restore
This method allows to delete a transaction which must be in '**New**' or '**Draft**' states. If the transaction has another state, the 403 error will be raised. The result of the operation is a full set of the fields which the transaction has before deletion.
### REQUEST:
       DELETE     /api/v1/transactions/:id
### ARGUMENTS:
       **id** is an obligate field passed as a part of the url.
### EXAMPLE:
```bash
TOKEN="your access token here"
curl -X DELETE -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" https://api.projectdgc.com/api/v1/transactions/4350
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
  "state":"Deleted", 
  "state_changed": "2015-03-18T07:48:27.729+0000",
  "direction":0,
  "modified": "2015-05-13T14:36:53.280+0000"
}
```
All the fields are the same as for others transaction requests.

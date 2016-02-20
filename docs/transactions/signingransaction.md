# Signing a transaction
Requests user's approvement for a transaction
First of all, this method changes the state of a transaction to '**Unconfirmed**' and sends a USSD query to the user's mobile phone
### REQUEST:
       PUT     /api/v1/transactions/:id/sign
### ARGUMENTS:
       **id** is an mandatory field passed as a part of the url.
### EXAMPLE:
```bash
TOKEN="your access token here"
curl -X PUT -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" https://api.projectdgc.com/api/v1/transactions/4350/validate
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
  "state":"Unconfirmed", 
  "state_changed": "2015-03-18T07:48:27.729+0000",
  "direction":0,
  "modified": "2015-05-13T14:36:53.280+0000"
}
```
All the fields are the same as for others transaction requests.

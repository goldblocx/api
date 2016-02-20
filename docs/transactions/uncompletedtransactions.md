# Uncompleted transactions

List of uncompleted transactions
Returns a list of transactions which are not completed or not sent by user

### REQUEST:

       GET     /api/v1/transactions/notcompleted
       
### ARGUMENTS:
       Additional request parameters can be used for filtering and paging the transactions in the list.
       page - number of current page
       per_page - number of item in the page

### EXAMPLE:
```bash
TOKEN="your access token here"
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" https://api.projectdgc.com/api/v1/transactions/notcompleted?page=0&per_page=5
```

### RESPONSE:
```javascript
[
  {  "created":"2015-05-13T12:19:17.512+0000",
     "id":12301, 
     "details":"Invoce # 2332",
     "amount": 5.00000,
     "account": { 
                   "description":"Current",
                   "id":4750,
                   "type":"Common"
                },
     "contact":"7 912 2437136", 
     "contact_type":"Phone",
     "state":"Cancelled", 
     "direction":0
  }
]
```

The fields in the provided transaction model are the same as for list of confirmed transactions but with small difference: the direction field is always 0 (because we deal with outgoing transactions only) and the state field can be New, Draft, Validate, Unconfirmed and Confirmed.

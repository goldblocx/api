# List of Completed Transactions

Returns a list of completed transactions available for the current customer.

### REQUEST:

```
    GET     /api/v1/transactions
```

### ARGUMENTS:

Additional request parameters can be used for paging transactions in the list:

- **page** - number of current page
- **per_page** - number of items in the page
- **sort=+/-created** or **sort=+/-executed** - sorting by the time of creation/execution.

### EXAMPLE:

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/transactions?page=0&per_page=5?sort=-executed
```

### SAMPLE of RESPONSE:

Returns a list of [transactions](../models/transaction.md).

```json
[
  {
    "created": "2020-05-13T12:19:17.512+0000" ,
    "id": 1234567 ,
    "details": "Invoce # 2332" ,
    "amount": 5.00000 ,
    "account": {
      "description": "Current" ,
      "id": 4750 ,
      "type": "Common"
    } ,
    "contact": "791211111" ,
    "contact_type": "Phone" ,
    "state": "Cancelled" ,
    "direction": 0 ,
    "modified": "2020-03-18T07:45:24.806+0000" ,
    "state_changed": "2020-03-18T07:45:24.797+0000"
  } ,
  {
    "created": "2020-03-18T15:46:04.160+0000" ,
    "id": 7654321 ,
    "details": "Money transfer" ,
    "amount": 23.01 ,
    "account": {
      "description": "Current" ,
      "id": 4750 ,
      "type": "Common"
    } ,
    "contact": "mail@mail.com" ,
    "contact_type": "Email" ,
    "state": "Completed" ,
    "direction": 1 ,
    "modified": "2020-03-16T11:00:12.375+0000"
  } ,
  ...
]
```

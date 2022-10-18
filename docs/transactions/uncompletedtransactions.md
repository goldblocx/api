# Draft Transactions

Returns a list of transactions which are not completed or not sent by user, for example,
drafts or ready-to-sign transactions.

### REQUEST:

```
    GET /api/v1/transactions/notcompleted
```

### ARGUMENTS:

Additional request parameters can be used for paging transactions in the list.

- **page** - number of the current page
- **per_page** - number of items in the page

### EXAMPLE:

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" \
             $API_HOST/api/v1/transactions/notcompleted?page=0&per_page=5
```

### RESPONSE:

```json
[
  {
    "created": "2020-05-13T12:19:17.512+0000" ,
    "id": 1234567 ,
    "details": "Invoce # 2332" ,
    "amount": 5.00000 ,
    "account": {
      "description": "Current" ,
      "id": 12345 ,
      "type": "Common"
    } ,
    "contact": "6578767687" ,
    "contact_type": "Phone" ,
    "state": "Cancelled" ,
    "direction": 0
  } ,
  ...
]
```

The fields in the provided transaction model are the same as for list of
[confirmed transactions](./completedtransactions.md) but with a small difference:
the state field can be **New**, **Draft**, **Validated**, **Unconfirmed** only.

The latter is the state when the corresponding transaction is attempted to be confirmed by a user.

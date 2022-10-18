# Validating a Transaction

Changes the transaction's state to the 'Validate' one and conducts checking
the fields of the transaction according to its type.

This method allows to change the transaction's state, if it is in the **Draft** state.
For other states the "Transaction state is invalid" error will be generated.

### REQUEST:

```
   PUT /api/v1/transactions/:id/validate
```

### ARGUMENTS:

> **id** - the ID of the transaction

### EXAMPLE:

```bash

# Transaction body
MODEL='{"id" : 4350, ... }

curl -X PUT  -H "Authorization: Bearer $TOKEN" \
             $API_HOST/api/v1/transactions/1234567/validate
```

### RESPONSE:

```json
{
  "created": "2020-05-13T12:19:17.512+0000" ,
  "id": 1234567 ,
  "details": "Invoice # 2433" ,
  "amount": 5.03 ,
  "account": {
    "description": "Current" ,
    "id": 12345 ,
    "type": "Common"
  } ,
  "contact": "6578763626" ,
  "contact_type": "Phone" ,
  "state": "Validated" ,
  "state_changed": "2020-03-18T07:48:27.729+0000" ,
  "direction": 0 ,
  "modified": "2020-05-13T14:36:53.280+0000"
}
```

All the fields are the same as for others [transaction requests](../models/transaction.md).

# Removing Transactions

Deletes a transaction without a possibility to restore.

This method allows to delete a transaction which is in the '**New**' or '**Draft**' states.
If the transaction has another state, the 403 error will be raised.

The result of the operation is a full set of the fields which the transaction has had before deletion.

### REQUEST:

```
    DELETE     /api/v1/transactions/:id
```

### ARGUMENTS:

> **id** - The ID of the transaction

### EXAMPLE:

```bash
curl -X DELETE -H "Authorization: Bearer $TOKEN" \
                $API_HOST/api/v1/transactions/1234567
```

### RESPONSE:

```json
{
  "created": "2020-05-13T12:19:17.512+0000" ,
  "id": 1234567 ,
  "details": "Invoce # 2433" ,
  "amount": 5.02 ,
  "account": {
    "description": "Current" ,
    "id": 12345 ,
    "type": "Common"
  } ,
  "contact": "79122400000" ,
  "contact_type": "Phone" ,
  "state": "Deleted" ,
  "state_changed": "2020-03-18T07:48:27.729+0000" ,
  "direction": 0 ,
  "modified": "2020-05-13T14:36:53.280+0000"
}
```

The fields in the provided transaction model are the same as for lists of transactions,
([see completed transaction model](../models/transaction.md)).

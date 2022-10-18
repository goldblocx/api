# Sending money to a bank account

The key attributes for this type of transaction are "transaction_type", "direction"
and "external_channel". The "transaction_type" must be specified as "External",
the "external_channel" field must be equal to "BankAccount" and the "direction"
should be equal to "0" (i.e. outward transactions).

In the case when the "related_currency" and account's currency are not equals -
the currency exchange should be applied ([see currency exchange](../../products/exchangetransaction.md)).

### REQUEST:

```
    POST /api/v1/transactions
```    

### ARGUMENTS:

```json
{
  "transaction_type": "External" ,
  "external_channel": "BankAccount" ,
  "direction": 0 ,
  "account": {
    "id": ... ,
    ...
  } ,
  "amount": ... ,
  "related_currency": {
    "asset_id": "..."
  } ,
  "bank_account": {
    "account_number": "..." ,
    "account_owner_name": "..." ,
    "bank_code": "..." ,
    "tax_number": "..."
  }
}
```

### EXAMPLE:

```bash
MODEL='{ 
     "transaction_type" : "External",
     "external_channel" : "BankAccount",
     "direction" : 0,
     "account" : {"id", 1234567},
     "related_currency":{"value" : "EUR"},
     "amount" : 100.00,
     "bank_account" : 
     { 
        "account_number" : "09828098388",
        "account_owner_name" : "John Smith Junior the Third", 
        "bank_code" : "INKROOM2XX",
        "tax_number" : "667867876789"
     }
}'
              
curl -X POST -H "Authorization: Bearer $TOKEN" \ 
             -d $MODEL \
              $API_HOST/api/v1/transactions
```

The same model is applied in case of modifying transactions but instead of a **POST**
you need to use a **PUT** request and also to specify the "**id**" field
in a transaction model in the body of request.

All further processing stages (validation, sign, retrieving, deletion) currently
the same as in case of general transaction ([see transactions](../transactions.md)).

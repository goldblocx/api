# Creating new exchange transaction (converting assets/currencies)

Creates a new transaction from a special JSON model. The operation looks very similar
to the creation of ordinal transaction. But in the case of exchange transactions
we need to provide both source and target accounts in the model.

A list of accounts available for the current customer can be obtained by
[the accounts query](./accounts.md).
Also, you need to specify the transaction_type field to be "Transfer".

### REQUEST:

```
    POST /api/v1/transactions
```

### REQUEST BODY:

```json
   {
  "transaction_type": "Transfer" ,
  "account": {
    "id": ...
  } ,
  "related_account": {
    "id": ...
  } ,
  "amount": ... ,
  "related_amount": ...
}
```

### EXAMPLE

```bash
MODEL='{
  "transaction_type":"Transfer", 
  "account" : {
    "id" : 1234567
  }, 
  "related_account" : {
    "id" : 7654321
  } 
}'

curl -X POST -H "Content-Type: application/json" \
             -H "Authorization: Bearer $TOKEN" \
              $API_HOST/api/v1/transactions \
             -d $MODEL
```

### RESPONSE:

```json
{
  "account": {
    "currency": {
      "description": "USD" ,
      "value": "USD"
    } ,
    "id": 1234567
  } ,
  "code": 0 ,
  "created": "2020-08-03T07:35:25.270+0000" ,
  "details": "Transfer between accounts" ,
  "direction": 0 ,
  "id": 935552 ,
  "modified": "2020-08-03T07:35:25.274+0000" ,
  "related_account": {
    "currency": {
      "description": "EUR" ,
      "value": "EUR"
    } ,
    "id": 7654321
  } ,
  "state": "New" ,
  "state_changed": "2020-08-03T07:35:25.270+0000" ,
  "transaction_type": "Transfer"
}
```

The fields in the provided transaction model are mostly the same as for lists of
transactions (see [Transactions](../transactions/transactions.md)).
But also the 'Transfer' transactions contain the field "transaction_type" to be equal
to "Transfer" and the "related_account" field with information about the second
account used in the transfer.

# Modifying Exchange Transaction

This method works for a transaction in the 'New' or 'Draft' state with the "Transfer"
"transaction_type". Mostly, all transaction fields are exactly the same as in the case
of editing a "Default" transaction,
but the transaction model also contains the fields connected with other side of
transaction like "related_account", "related_amount".

In the case when the currencies of the accounts in the transaction are different
we need to calculate the related_amount field using the [exchange Rate function](./rates.md).

For example, if you have two accounts in the USD (the source) and EUR (the target)
currencies, and you need to convert 100 USD to some EUR value, you should run
the ['api/v1/rates'](./rates.md) operation specifying the source_code in USD,
the target_code as EUR and the source_amount to be 100.

In the response you will get the 'target_value' field with amount of converted
currency (in EUR). Then you should use these calculated values as the 'amount' and
'related_amount' fields correspondingly.

In case of changing the current exchange rate you will get a validation message
when performing the validation procedure (HTTP 400, the "Bad Request" error).

In this case the response model will be like:

```json
{
  "code": 1 ,
  "error_id": "transaction.rate.is.changed" ,
  "message": "The exchange rate has changed"
}
```

In this situation you should recalculate the amounts and perform the validation again.

### REQUEST:

```
    PUT  /api/v1/transactions
```    

### ARGUMENTS:

```json
{
  "id": "..." ,
  "transaction_type": "Transfer" ,
  "amount": "..." ,
  "related_amount": "..." ,
  "account": "..." ,
  "related_account": "..."
}
```

> **id** - the ID of the transaction

### EXAMPLE:

```bash               
MODEL='{
    "id" : "3455", 
    "amount": "5.003",
    "related_amount" : 100.00
}'

curl -X PUT -H "Authorization: Bearer $TOKEN" \
             $API_HOST/api/v1/transactions \
            -d $MODEL
```

### RESPONSE:

```json
{
  "account": {
    "currency": {
      "description": "USD" ,
      "value": "USD"
    } ,
    "id": 1234567
  } ,
  "amount": 3.0 ,
  "created": "2020-08-03T07:35:25.270+0000" ,
  "details": "Transfer between accounts" ,
  "direction": 0 ,
  "id": 3455 ,
  "modified": "2020-08-03T08:28:26.516+0000" ,
  "related_account": {
    "currency": {
      "description": "EUR" ,
      "value": "EUR"
    } ,
    "id": 7654321
  } ,
  "related_amount": 100.0 ,
  "state": "Draft" ,
  "state_changed": "2020-08-03T09:28:37.232+0000" ,
  "transaction_type": "Transfer"
}
```

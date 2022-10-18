# Sending Funds to a Bank Card

The key attributes for this type of transaction are "transaction_type", "direction"
and "external_channel".

The "transaction_type" must be specified as "External", the "external_channel"
field must be equal to "Card" and the "direction" should be equal to "0" (i.e. outward).

In the case when the "related_currency" and account's currency are not equals -
the currency exchange should be applied ([see currency exchange](../../products/exchangetransaction.md)).

### REQUEST:

```
    POST     /api/v1/transactions
```

### REQUEST BODY:

```json
{
  "transaction_type": "External" ,
  "external_channel": "Card" ,
  "direction": 0 ,
  "account": {
    "id": "..." ,
    ...
  } ,
  "amount": ... ,
  "related_currency": {
    "value": "..."
  } ,
  "card": {
    "last_four_digits": "..." ,
    ...
  }
}
```

### EXAMPLE:

```bash
MODEL='{
    "transaction_type" : "External",
    "external_channel" : "Card",
    "direction" : 0,
    "account" : {"id": "650650"},
    "related_currency":{"value" : "EUR"},
    "amount" : 100.00,
    "card" : {"last_four_digits":"1111", ... }
}'

curl -X POST -H "Authorization: Bearer $TOKEN" \
             -d $MODEL $API_HOST/api/v1/transactions
```

The same model is applied in case of editing a transaction but instead of a **POST**
you need to use a **PUT** request and also to specify the "**id**" field
in a transaction model in the body of request.

All further processing stages (validation, sign, retrieving, deletion) currently
the same as in case of general transaction ([see transactions](../transactions.md)).

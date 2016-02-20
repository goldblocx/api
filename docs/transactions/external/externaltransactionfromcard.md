# Creates a new transaction

The key attributes for this type of transaction are "transaction_type", "direction" and "external_channel". 
The "transaction_type" must be specified as "External", the "external_channel" field must be equal to "Card" 
and the "direction" should be equal to "1" (i.e. incoming).
In the case when the "related_currency" and account's currency are not equal - the currency exchange should be applied 
[see Currency Exchange](./currenciesfortransaction.md). To obtain a valid exchange rate you need to specify the value "FromCard" as the "product" 
field value in "/api/v1/rates".

### REQUEST:

       POST     /api/v1/transactions

### ARGUMENTS:

       request body: { "transaction_type" : "**External**", 
                       "external_channel" : "**Card**", 
                       "direction" : **1**, 
                       "account" : { "id":"..." , ...}, 
                       "amount" : "...", 
                       "related_currency" : {"value" : "..."}, 
                       "card" : { "card_bin": "...",
                                  "last_four_digits":"...",
                                  "cardholder_name" : "...",
                                  "valid_thru" : "..." }
                     }

### EXAMPLE:

```bash
TOKEN="your access token here"
curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" 
     -d '{"transaction_type" : "External", "external_channel" : "Card","direction" : 1, "account" : {"id", 650650}, "related_currency":{"value" : "EUR"}, "amount" : 100.00, "card" : {"card_bin" : "111111", "last_four_digits":"1111", "cardholder_name" : "John Smith", "valid_thru" : "09/18"}  }' https://api.projectdgc.com/api/v1/transactions
```

### RESPONSE:

```javascript

{
  "account": {
        "currency": {
            "description": "USD",
            "value": "USD"
        },
        "description": "Bucks",
        "id": 650650,
        "type": "Common"
    },
    "amount": 100.0,
    "card": {
        "card_bin":"411111",
        "last_four_digits":"1111",
        "cardholder_name": "John Smith",
        "valid_thru": "09/18"
    },
    "code": 0,
    "created": "2015-08-10T03:53:28.549+0000",
    "details": "Fill or withdraw transaction",
    "direction": 1,
    "external_channel": "Card",
    "id": 993901,
    "modified": "2015-08-10T04:23:12.126+0000",
    "related_amount": 0,
    "related_currency": {
        "description": "EUR",
        "value": "EUR"
    },
    "state": "New",
    "state_changed": "2015-08-10T04:23:12.128+0000",
    "transaction_type": "External"
}
```



The most of the fields are the same as for general transaction [see Transactions](../transactions.md). 
The expected format for the "valid_thru" field is "MM/YY" - the month and year of card expiration.
The same model is applied in case of editing a transaction but instead of POST you need to use a PUT request 
(you need then specify the "id" field in a transaction model). CARD DATA NOT SAVE on simple POST and PUT.

# Card data save only in PUT /api/v1/transactions/:id/validate.
For existing card, '**id**' is required in card object  (Card is saved after successful transaction, for retrieving see [get cards](../../products/cards.md) )
For '**encrypt_data**' in card object [see get encrypt data](./encryptcarddata.md)
### REQUEST:

       PUT     /api/v1/transactions/:id/validate

### ARGUMENTS:

       request body: { "transaction_type" : "External", 
                       "external_channel" : "Card", 
                       "direction" : 1, 
                       "account" : { "id":"..." , ...}, 
                       "amount" : "...", 
                       "related_currency" : {"value" : "..."},
                       "card" : { "id": "...",
                                  "card_bin": "...",
                                  "last_four_digits":"...",
                                  "cardholder_name" : "...",
                                  "valid_thru" : "...", 
                                  "encrypt_data" : "..." }
                     }
                     
### EXAMPLE:

```bash
TOKEN="your access token here"
curl -X PUT -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" 
     -d '{"transaction_type" : "External", "external_channel" : "Card","direction" : 1, "account" : {"id", 650650}, "related_currency":{"value" : "EUR"}, "amount" : 100.00, "card" : {"card_bin" : "111111", "last_four_digits":"1111", "cardholder_name" : "John Smith", "valid_thru" : "09/18", "encrypt_data" : "adyenjs_0_1_16$1qxZVgjVyyziayLtky9UpQ18e7DeHU2OaGKiIpzD574CKSBdsWNtRNUIQJdfrEjQBfXG5Mw5/NbfAUbXolqdSEaIvocf+rWaf+Z7+jGlabJboCQWrFW3AFapRQ9BGHMyXXEn1CZfTYgc8A+A1BS1ctuG1GADrorFcvUH958XVABUwSYkUSifkqtBSaLzKpclCUXJx5FRE2y4EdgMBMNaAytBmpXOEFQuzDfl1bRF+GrQ0CXdn+k1CazySW7FdLFvrRv6K/mV3SrUHRTVy51ztwovDDNl9Wt6dXy5Xhdc0xw+Om5RPPvrqz6J5sEMGsIdKCK3VWwrYOyqCMqFd/rFBg==$r1RSGOiE0bfNyWYHQIlYjnhjKgsD1Q1cwqyDMnpGcSAdGwvIBik4VatqauebFEKQO634arRLpmTxD1e2w+bcPIM9pKeeQ/BZj5Kd6BFBXMuK/XqLaC//RKenDGKJqFNZmf8V3mzBKDN9w30/Wj8sVjb0Lxpnnj2Hxwv7ma3Z42CE25gJN4pgG+hQj+KIkN0u+41ADNYHUNgD72pjDVTZOB5oKWOgmYNsdj+z77XVpJMUjLr2nsGBG78RaCfLcA5eTspK/cKAukLi0dlyiKDlyZbe30/9nUfcoAmJjMTvdmq2/XZX3imPvFAQAdWvOqsQ3NmHdsv6eftuXLEYBlRGm2iNNaVwZ4tAx+YBApbyG6Ucqn2ysMFNo+qUAl8="}  }' https://api.projectdgc.com/api/v1/transactions/993901/validate
```

### RESPONSE:

```javascript

{
  "account": {
        "currency": {
            "description": "USD",
            "value": "USD"
        },
        "description": "Bucks",
        "id": 650650,
        "type": "Common"
    },
    "amount": 100.0,
    "card": {
        "card_bin":"411111",
        "last_four_digits":"1111",
        "cardholder_name": "John Smith",
        "valid_thru": "09/18"
    },
    "code": 0,
    "created": "2015-08-10T03:53:28.549+0000",
    "details": "Fill or withdraw transaction",
    "direction": 1,
    "external_channel": "Card",
    "id": 993901,
    "modified": "2015-08-10T04:23:12.126+0000",
    "related_amount": 0,
    "related_currency": {
        "description": "EUR",
        "value": "EUR"
    },
    "state": "Validate",
    "state_changed": "2015-08-10T04:23:12.128+0000",
    "transaction_type": "External"
}
```

All further processing stages (sign, retrieving, deletion) 
currently the same as in case of general transaction [see Transactions](../transactions.md).

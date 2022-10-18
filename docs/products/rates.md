# Exchange Rates

This operation allows calculating amounts with the use of the current exchange rates.

Provides the exchange rate, converted amounts for some parameters of the exchange deal.
In the body of the request you should provide a currency code (the asset's identifier)
both source and target currencies ("source_code" and "target_code" fields)
and some amount to convert.

The value can be specified in source or target currency ("source_value" or "target_value").

### REQUEST:

```
    PUT /api/v1/rates
```

### EXAMPLE

```bash

# Calculating a conversion 1 g XAU -> x USD, x = ?
MODEL='{
  "source_code":"XAU", 
  "target_code":"USD", 
  "source_value": 1.00000
}'
curl -X PUT -H "Authorization: Bearer $TOKEN" \
             $API_HOST/api/v1/rates \
            -d $MODEL
```

### RESPONSE:

```json
{
  "code": 0 ,
  "rate": 31.95784209 ,
  "source_code": "XAU" ,
  "source_value": 1.00007 ,
  "target_code": "USD" ,
  "target_value": 31.96
}
```

The result contains mostly the same fields and also the field missed in the request
("source_value" or "target_value" which will have the converted value).

Depending on the exchange rate the original target or source value can be also
recomputed to ensure the correct rounding, i.e. you can't buy less than, for instance,
0.01 USD or less than 0.00001 grams of gold (XAU) - it will always be rounded.

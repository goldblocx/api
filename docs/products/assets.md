# Currencies and Assets

Initially, the platform deals with several categories of currencies: fiat currencies
(like USD, SGD), pool allocated previous metals and tokens. We provide a very simple
way to open accounts in those currencies and to perform trading using the current
market prices.

If you run a custom application, you have an opportunity to create own currency
(we prefer the term 'asset') and to perform exchange operations.
For creation of own asset please refer to [the asset section](../applications/own_assets.md).

Here we consider functions connected with conversions of assets (currencies):

1. [Get Available Assets/Currencies](#get-available-assets)
2. [Exchange Rates](./rates.md)
3. [Converting Assets/Currencies](./exchangetransaction.md)

## Get Available Assets

The endpoint to receive a list of the available assets:

```bash

curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/assets/provider

# Or alternatively.
curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/currencies
```

The result will be a [list of assets](../models/asset.md).

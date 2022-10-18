# Introduction to Assets

Assets represent some values which can be stored in the system, can be traded and
transferred. Those can be currencies like US Dollar or Euro, but at the same time
assets depict a more wide class of values: gold, silver, oil, bitcoin, loyalty points
or others.

For additional details on asset objects please refer to [the asset model](../models/asset.md).

You can open accounts using these standard or custom assets, transfer between your clients (using
[transactions](../transactions/transactions.md)) or even [convert assets](../products/exchangetransaction.md) from one
to others (using market-based exchange rates or custom price models).

But at the same time if you use your [own applications](./registration.md), you can
register own assets and provide different aforementioned operations with these assets
for your own clients. The assets can be tokens, loyalty points or any other type of
assets which are not the securities.

1. [Creating Assets](#creating-assets)
2. [Activating Assets](#activating-assets)
4. [Modifying Assets](#modifying-assets)
5. [Querying Assets](#querying-assets)
6. [Querying a Single Asset](#querying-a-single-asset)
7. [Retrieving Assets by Provider](#retrieving-assets-by-provider)
8. [Removing Assets](#removing-assets)

# Creating Assets

To create an asset you need to provide its code, the description and the scale.

### REQUEST:

```
    POST /api/v1/assets
```    

### REQUEST BODY:

```json
{
  "asset_code": "..." ,
  "description": "..." ,
  "scale": "..."
}
```

The field 'scale' means how many fraction digits should have the asset. For example,
it must be set 2 for US Dollar, or it is set 5 for precious metals.

### EXAMPLE

```bash
MODEL='{
  "asset_code" : "BTC", 
  "description" : "Stable SuperBitcoin", 
  "scale": "8" 
}'

curl -X POST -H "Authorization: Bearer $TOKEN" \
             -d $MODEL \
             $API_HOST/api/v1/assets
```

### RESPONSE:

```json
{
  "code": 0 ,
  "scale": 8 ,
  "description": "Stable SuperBitcoin" ,
  "asset_id": "b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121" ,
  "asset_code": "BTC"
}
```

In the generated response the 'asset_id' field represents the unique identifier of
the asset which must be used further in all operations.

# Activating Assets

After creation of a new asset, you need to activate it before start using. The activation
procedure means changing the state of the asset to 'Active' and issuing the intial
volume of the asset.

### REQUEST:

```
    PUT /api/v1/assets/:assetId/activate
```

### REQUEST BODY:

```json
{
  "asset_code": "..." ,
  "description": "..." ,
  "scale": "..." ,
  ...
}
```

In the request body we should provide the asset's model.

### EXAMPLE

```bash
MODEL='{
  "asset_code" : "BTC", 
  "description" : "Stable SuperBitcoin", 
  "scale": "8" 
}'

curl -X POST -H "Authorization: Bearer $TOKEN" \
             -d $MODEL \
             $API_HOST/api/v1/assets/b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121/activate
```

### RESPONSE:

In the response there will be the asset's model.

```json
{
  "scale": 8 ,
  "description": "Stable SuperBitcoin" ,
  "asset_id": "b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121" ,
  "asset_code": "BTC" ,
  ...
}
```

If you use USSD as an additional factor, then a USSD confirmation dialog will be
sent to your mobile phone. If you use the SMS channel for confirmations, then
an SMS message will be sent. In this case, a model with an OTP number is returned:

```json
{
  "scale": 8 ,
  "description": "Stable SuperBitcoin" ,
  "asset_id": "b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121" ,
  "asset_code": "BTC" ,
  "otp_num": "34"
}
```

To confirm the asset's activation, you need to invoke the following operation with
the model from above and the OTP code:

```bash
MODEL='{
  "asset_code" : "BTC", 
  "description" : "Stable SuperBitcoin", 
  "scale": "8",
  "otp_num": "34",
  "otp": "0232"
}'

curl -X PUT -H "Authorization: Bearer $TOKEN" \
             -d $MODEL \
             $API_HOST/api/v1/confirm/assets/b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121
```

# Modifying Assets

You can modify some fields like 'description', 'asset_code' and 'scale'.

### REQUEST:

```
    PUT /api/v1/assets/:assetId
```

### ARGUMENTS:

> **assetId** - The ID of the asset

### REQUEST BODY:

```json
    {
  "asset_code": "..." ,
  "description": "..." ,
  "scale": ... ,
  "asset_id": "..."
}
```

The only difference from the POST query is the presence of the field 'asset_id'.

### EXAMPLE

```bash
MODEL='{
   "asset_code" : "ETH", 
   "description" : "Ethereum", 
   "scale": "8", 
   "asset_id" : "b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121" 
}'

curl -X PUT -H "Authorization: Bearer $TOKEN" \
            -d $MODEL \
            $API_HOST/api/v1/assets
```

### RESPONSE:

```json
{
  "code": 0 ,
  "scale": 8 ,
  "description": "Ethereum" ,
  "asset_id": "b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121" ,
  "asset_code": "ETH"
}
```

Be careful changing the field 'scale' - for existing transactions and accounts it
will mean **denomination**.

# Querying Assets

Using this query, you will be able to get the whole list of own assets. The request
will work if only you are logged via the application which has been used to create
these assets.

### REQUEST:

```
    GET /api/v1/assets
```

### EXAMPLE

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/assets
```

### RESPONSE:

```json
[
  {
    "code": 0 ,
    "scale": 8 ,
    "description": "Ethereum" ,
    "asset_id": "b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121" ,
    "asset_code": "ETH"
  } ,
  {
    "code": 0 ,
    "scale": 0 ,
    "description": "OIL (barrels)" ,
    "asset_id": "dc6054c0-792e-4979-afca-f66f89ee4586" ,
    "asset_code": "OIL"
  } ,
  ...
]
```

In the case when you wish to obtain the list of all assets available for you including the public assets from Copernicus
Gold, you need to use the '/api/v1/currencies' endpoint.

# Querying a Single Asset

Use this query to get information about one asset.

### REQUEST:

```
    GET /api/v1/assets/:id
```

### ARGUMENTS:

> **id** - the ID of the asset (the 'asset_id' in the previous queries).

### EXAMPLE

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/assets/b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121
```

### RESPONSE:

```json
  {
  "code": 0 ,
  "scale": 8 ,
  "description": "Ethereum" ,
  "asset_id": "b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121" ,
  "asset_code": "ETH"
}
```

# Retrieving Assets by Provider

Returns all assets that are available under the current provider.

```
    GET /api/v1/assets/provider
```

### ARGUMENTS:

> **id** - the identifier of the asset (the 'asset_id' in the previous queries).

### EXAMPLE

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" \
               $API_HOST/api/v1/assets/provider
```

### RESPONSE:

```json
[
  {
    "scale": 2 ,
    "description": "Euro" ,
    "asset_id": "EUR" ,
    "asset_code": "EUR" ,
    "symbol": "€" ,
    "position": 0
  } ,
  {
    "scale": 2 ,
    "description": "US Dollar" ,
    "asset_id": "USD" ,
    "asset_code": "USD" ,
    "symbol": "$" ,
    "position": 0
  } ,
  ...
]
```

# Removing Assets

In the case when some asset is not required anymore you can remove it. If you have some
transactions and accounts for this asset, the asset will change its state to 'Inactive'
and it will be unable to use.

If the asset has non-zero volume in the circulation, an error will be generated.

### REQUEST:

```
    DELETE /api/v1/assets/:id
```

### ARGUMENTS:

> **id** - the identifier of the asset (the 'asset_id' in the previous queries).

### EXAMPLE

```bash
curl -X DELETE -H "Authorization: Bearer $TOKEN" \
               $API_HOST/api/v1/assets/b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121
```

### RESPONSE:

```json
{
  "code": 0 ,
  "scale": 8 ,
  "description": "Ethereum" ,
  "asset_id": "b81a4a7d-6af4-4ef0-ba7f-cdcaf856f121" ,
  "asset_code": "ETH"
}
```

The response represents the model of the deleted asset.

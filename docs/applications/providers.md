# Providers

Providers are services that may have own products, currencies (assets),
fees and other settings. You can implement several distinguish providers which
can operate under own brands and have various applications.

Providers can be created by corporate entities, please refer to the
[customers section](../customers.md) to find how to switch to a corporate entity.

All available attributes of providers can be found [here](../models/provider.md).

* [Creating Providers](#creating-providers)
* [Modifying Providers](#modifying-providers)
* [Retrieve Providers](#retrieve-providers)
* [Current Provider](#current-provider)
* [Changing Current Provider](#changing-current-provider)

## Creating Providers

A provider is created automatically when you [create your first application](./applications.md)
and there is no function to create a new provider.

## Modifying Providers

You can update certain attributes of providers.

### REQUEST:

```
    PUT /api/v1/providers/:id
```

### ARGUMENTS:

> **id** - the ID of the provider

### BODY:

```json
{
  "name": "New Name to Update"
}
```

### EXAMPLE

```bash
ID=12345

MODEL=`{
  "name" : "New Name to Update"
}`

curl -X PUT -H "Authorization: Bearer $TOKEN" \
            -d "$MODEL" \
            $API_HOST/api/v1/applications/$ID
```

### RESPONSE:

```json
{
  "id": 12345 ,
  "created": "2021-10-15T05:27:47.135+0000" ,
  "modified": "2021-10-15T05:27:47.270+0000" ,
  "name": "New Name to Update" ,
  "customer": {
    "id": 987654321 ,
    "name": "Company Ltd." ,
    "type": "Corporate" ,
    "kind": "Organization" ,
    "business_code": "0d8fe1db-3d5b-4178-a45a-c431d1840e0a"
  } ,
  "provider_code": "2d5b17f1-072a-48cf-85f1-04839beaf5b1" ,
  "default_currency": "USD" ,
  "country": {
    "description": "Singapore" ,
    "value": "SG"
  } ,
  "category": "COMMON" ,
  "rate_provider": "gsc_pump" ,
  "time_zone": "Asia/Yekaterinburg"
}
```

## Retrieve Providers

You can update certain attributes of providers.

### REQUEST:

```
    GET /api/v1/providers
```

### EXAMPLE

```bash
curl -X PUT -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/providers
```

### RESPONSE:

The resulted list of currently available providers:

```json
[
  {
    "id": 12345 ,
    "created": "2021-10-15T05:27:47.135+0000" ,
    "name": "Provider Name 1" ,
    "provider_code": "2d5b17f1-072a-48cf-85f1-04839beaf5b1" ,
    ...
  } ,
  {
    "id": 54321 ,
    "created": "2021-10-15T05:27:47.135+0000" ,
    "name": "Provider Name 2" ,
    ...
  }
]
```

## Current Provider

Retrieves the current provider.

### REQUEST:

```
    GET /api/v1/providers/current
```

### EXAMPLE

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/providers/current
```

### RESPONSE:

The resulted model with the details of the current provider:

```json
{
  "id": 12345 ,
  "created": "2021-10-15T05:27:47.135+0000" ,
  "modified": "2021-10-15T05:27:47.270+0000" ,
  "name": "New Name to Update" ,
  ...
}
```

## Changing Current Provider

Sets a new current provider from the list of available ones.

### REQUEST:

```
    PUT /api/v1/providers/:id/current
```

### ARGUMENTS:

> **id** - the ID of the provider

### EXAMPLE

```bash
ID=12345

curl -X PUT -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/providers/$ID/current
```

### RESPONSE:

Returns the details of the new provider.

```json
{
  "id": 12345 ,
  "created": "2021-10-15T05:27:47.135+0000" ,
  "modified": "2021-10-15T05:27:47.270+0000" ,
  "name": "Provider Name" ,
  ...
}
```

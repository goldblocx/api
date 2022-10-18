# Provider Model

The providers are the aggregates which allow to combine several application
which are close to each other from the point of the service. If you create,
for instance, a loyalty point provider, you can create two applications
(e.g. web and mobile) that use the provider's loyalty points.

For more details on applications please refer to
[the application section](../applications/applications.md).

The provider's fields:

```json
{
  "id": 1234567 ,
  "created": "2019-10-26T20:06:11.161+0000" ,
  "customer": {
    "id": 987654321 ,
    "name": "Company Ltd." ,
    "type": "Corporate" ,
    "kind": "Organization" ,
    "business_code": "0d8fe1db-3d5b-4178-a45a-c431d1840e0a"
  } ,
  "name": "My Service" ,
  "provider_code": "2d5b17f1-072a-48cf-85f1-04839beaf5b1" ,
  "default_currency": "USD" ,
  "country": {
    "description": "South Africa" ,
    "value": "ZA"
  } ,
  "category": "COMMON" ,
  "rate_provider": "gsc_pump" ,
  "time_zone": "Africa/Johannesburg"
}
```

### id

The unique ID of the provider in the system. It must be used for all provider-related operations.

### created

The time of creation the provider's object.

### name

The name of the provider. It may appear, for example, in SMS messages or email sent by the system.

### customer

The linked customer - the owner of the provider. Each provider is linked to
a corporate entity. So that you should create a company before starting to work
with providers and applications. Please refer to [customer model section](./customer.md)
for more details on customers.

### default_currency

The provider's currency which is used by default, e.g. in fees, reports, trading and
others.

### country

The country where the provider is operating. Please refer to the [country model](../models/directories/country.md)
for details

### category

We use only one category for common service providers - **COMMON**. But there are some
other:

- **SERVICE** for internal service providers, e.g. exchange rate providers.
- **AGENT** for agents

### rate_provider

The code of the exchange rate provider from the currently supported ones, e.g.
'oanda', 'gsc', 'exante', 'moex' and some others if implemented.

### time_zone

The time zone ID for the provider. The time zone affect the scheduled operation
execution and the business day's start and end time.

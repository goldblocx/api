# Corporate Profile Model

The full information on the fields of corporate entities are available [here](../models/corporate.md).

Below we consider several API endpoints that are used for managing corporate
customers.

## Creating a new corporate entity

You need to be authorized as an individual customer to start creating.

```
    POST /api/v1/customers/corporate/data
```

As the request body we use the [corporate data model](../models/corporate.md).

```bash
MODEL='{
  "registration_number" : "237128376YD",
  "registration_date" : "2022-03-16",
  ...
}'

curl -X POST -H "Authorization: Bearer $TOKEN" \
             -d $MODEL \
             $API_HOST/api/v1/customers/corporate/data
```

After submitting the request you need to confirm the creation. If you were authorized
via the USSD channel, then a USSD dialog will be sent to your main phone number.

If you use the SMS channel, then an SMS message will be sent. For this case,
you need to use the following endpoint to complete the SMS confirmation.
Please read the [confirmation article](../confirmations.md) to understand our approaches
to confirmations of transactions and documents.

```bash
MODEL='{
  "otp_num" : "22",
  "otp" : "2312",
  "registration_number" : "237128376YD",
  "registration_date" : "2022-03-16",
  ...
}'

curl -X PUT -H "Authorization: Bearer $TOKEN" \
             -d $MODEL \
             $API_HOST/api/v1/confirm/corporate/:id
```

> **id** The ID is the customer's ID that was returned by the previous function

if due to some reasons you failed the confirmation or did not receive USSD/SMS,
you can initiate the confirmation procedure once again. Please use the following
endpoint:

```bash
MODEL='{
  "registration_number" : "237128376YD",
  "registration_date" : "2022-03-16",
  ...
}'

curl -X PUT -H "Authorization: Bearer $TOKEN" \
             -d $MODEL \
             $API_HOST/api/v1/customers/:id/corporate/activate
```

## Retrieving the corporate entity data

```
    GET /api/v1/customers/:id/corporate/data
```

> **id** The ID of the corporate customer.

As the result will be the [corporate data model](../models/corporate.md).

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" \
             $API_HOST/api/v1/customers/:id/corporate/data
```

## Adding a new affiliate person

You can add several persons to a corporate entity to allow them managing this entity.
Depending on the permission, some of them can transfer funds or just have read-only
access. Please refer the [affiliates corporate model section](../models/corporate.md)
to find more details about the permissions and the data models for such individuals.

The phone number is used here as an additional factor for verification - we allow
to connect the individual who has the given phone number as the main login only.

```bash
MODEL='{
  "is_director" : true,
  "is_organization_management" : false,
  "phone_number": "6529878398",
  ... other individual data ...
}'

curl -X PUT -H "Authorization: Bearer $TOKEN" \
             -d $MODEL \
             $API_HOST/api/v1/customers/:id/corporate/data/individual
```

Then, you need to confirm adding a person via a USSD dialog and by invocation
of the confirmation endpoint in case of the SMS channel. the model must be
the same as it was returned by the previous endpoint but with the "otp" value
to be inserted.

```bash
MODEL='{
  "otp_num" : "23",
  "otp" : "2312",
  "is_director" : true,
  "is_organization_management" : false,
  "phone_number": "6529878398",

  ... other individual data ...
}'

curl -X PUT -H "Authorization: Bearer $TOKEN" \
             -d $MODEL \
             $API_HOST/api/v1/confirm/corporate/:id/individual
```



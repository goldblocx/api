# Individual Customer Model

The full structure of models used for individuals [is provided here](../models/individual.md).
Below we consider typical operations that can be done for individuals.

Basically, all operations can be divided onto two pieces: setting data for the basic customer profile
and submitting data for the KYC procedure.

The customer is not allowed to modify their profile after starting the KYC procedure
because in this case all their data are considered as verified.

## Retrieving Customer Profile

This function returns the data model for the current authorized customer who must
be an individual person (not a corporate entity).

### REQUEST:

```
    GET /api/v1/customers/:id/individual/data
```

### ARGUMENTS:

> **id** The ID of the customer

### EXAMPLE

```bash
  curl -X GET -H "Authorization: Bearer $TOKEN" \
               $API_HOST/api/v1/customers/:id/individual/data
```

### RESPONSE:

```json
{
  "code": 0 ,
  "id": 1234567 ,
  "customer": {
    ...
  } ,
  "first_name": "Alexey" ,
  "full_name": "Romanchuk Alexey" ,
  ...
}
```

The result is a customer individual model. The whole list of fields can be
found [here](../models/individual.md)

## Modifying Customer Profile

This operation updates profile data based on the model specified in the request's body.

## REQUEST:

```
    PUT /api/v1/customers/:id/individual/data
```    

### ARGUMENTS:

> **id** The ID of the customer

### EXAMPLE

```bash
MODEL='{
  "id" : 1234567, 
  "birth_date" : "1978-11-14T00:00:00"
}'

curl -X POST -H "Authorization: Bearer $TOKEN" \
             -d $MODEL \
             $API_HOST/api/v1/customers/individual/data
```

In the response is the individual model.

## Submitting Data for KYC procedure (identification)

Before submitting the form to the KYC procedure, you need to prepare all necessary data for
[the individual model](../models/individual.md) (see the part connected with the identification).

The first endpoint is used just for saving data WITHOUT submitting them to the compliance service. Please
use this endpoint for store portions of data.

```bash
curl -X PUT -H "Authorization: Bearer $TOKEN" \
             $API_HOST/api/v1/identification/individuals/:id/save
```

Then, after storing all data you can submit the individual form.

```bash
curl -X PUT -H "Authorization: Bearer $TOKEN" \
             $API_HOST/api/v1/identification/individuals/:id
```

> **id** - The ID of the customer's ID.

After that, the compliance status for the customer will be changed to 'Accepted' and
then to 'Pending' when the request is delivered to the compliance officers.

Please [see the link for more details](../models/customer.md) on compliance states.


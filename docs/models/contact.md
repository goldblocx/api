# Contact Model

Contacts are communication channels with the customer. Currently, they can be mobile phones or email addresses.

Each contact object has the following structure:

```json
{
  "id": 1234567 ,
  "kind": "Other" ,
  "state": "Confirmed" ,
  "type": "Phone" ,
  "value": "6500001111"
}
```

Fields:

### kind

Can have two values: 'Main' or 'Other'. The 'main' contacts are used primary for
the authentication and delivering notifications. Other contacts may be used as payment
addresses.

### state

Possible values are 'New' and 'Confirmed'. If a contact is confirmed, it means that
the user has proved their ownership of the contact (e.g. by the provided OTP
which was sent to the mobile phone or by accepting the confirmation link sent
to the email address).

### type

There are two possible values:

* Phone - for mobile phones
* Email - for email addresses

### value

The value of the contact itself - the mobile phone number or the email address.

## Contact API

### Creating a new contact

This function allows to create a new contact for the current customer.

```bash
MODEL='{
  "kind" : "Other",
  "type" : "Phone",
  "value" : "+79122493802"
}'

curl -X POST -H "Authorization: Bearer $TOKEN"  \
            -d $MODEL \
            $API_HOST/api/v2/contacts
```

After invocation of this operation, an OTP is sent to the mobile phone or a
confirmation link is sent to the email address. To confirm email addresses,
you need to follow the link from the email. But for phone numbers, please
use the 'api/v1/confirm/contact/:id' endpoint below.

### Confirming Phone Numbers

This endpoint allows confirming the phone number by providing the OTP-code
that was sent to this mobile phone.

```bash

# the model must be the same as it was returned by 'POST /api/v2/contacts'
MODEL='{
  "id" :
  "kind" : "Other",
  "type" : "Phone",
  "value" : "+79122493802"
  "otp_num" : "54"
  "otp": "0938"
}'

curl -X PUT -H "Authorization: Bearer $TOKEN"  \
            -d $MODEL \
            $API_HOST/api/v1/confirm/contact/:id
```

> ***id*** - the ID of the Contact object.

### Get Contacts

Retrieving contacts of the current customer:

```bash
curl -X GET -H "Authorization: Bearer $TOKEN"  \
            $API_HOST/api/v2/contacts
```

if you need to request contacts of a customer by their ID, please use the following
endpoint:

```bash
curl -X GET -H "Authorization: Bearer $TOKEN"  \
            $API_HOST/api/v2/customers/:id/contacts
```

For both endpoints above, the result will be similar to this:

```json
[
  {
    "id": 1234567 ,
    "state": "Confirmed" ,
    "kind": "Main" ,
    "type": "Phone" ,
    "value": "6598092999"
  } ,
  {
    "id": 12345678 ,
    "state": "Confirmed" ,
    "kind": "Main" ,
    "type": "Email" ,
    "value": "x@mydomain.com"
  }
]
```

### Make the Given Contact 'Main'

By default, all new contacts are created with the kind = 'Other'. Such contacts
allow receiving funds, but they are not used for the authentication or receiving
notifications. You need to change the kind from 'Other' to 'Main'.

The following endpoint allows to do it:

```bash
MODEL='{
  "id" : ...
  "kind" : "Other",
  "type" : "Phone",
  "value" : "+79122493802"
}'

curl -X PUT -H "Authorization: Bearer $TOKEN"  \
            -d $MODEL \
            $API_HOST/api/v2/contacts/:id/main

```

A confirmation OTP code will be sent to the current mobile phone number or
a USSD dialog will be provided if the USSD channel was used.
To confirm, please use this endpoint with the body from the previous result
with the substituted "otp" field.

```bash
MODEL='{
  "id" : ...
  "kind" : "Other",
  "type" : "Phone",
  "value" : "+79122493802"
  "otp_num" : "21"
  "otp": "2313"
}'

curl -X PUT -H "Authorization: Bearer $TOKEN"  \
            -d $MODEL \
            $API_HOST/api/v1/confirm/contact/set/main/:id
```

### Check Phone Numbers or Emails

Please use the following API endpoint to verify whether the given mobile phone
number or the given email exists. Such a function allows to check the recipient
before doing a transfer.

```bash
curl -X GET -H "Authorization: Bearer $TOKEN"  \
            $API_HOST/api/v1/contacts/phone/:value/validate
            
curl -X GET -H "Authorization: Bearer $TOKEN"  \
            $API_HOST/api/v1/contacts/email/:value/validate            
```

> **value** - the mobile phone number or the email address

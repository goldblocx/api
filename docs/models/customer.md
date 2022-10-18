# Customer Model

The customers are main objects of the platform. They are responsible for owning
the information, products, documents and data. There are two types of customers:
individuals and corporate entities. The customers may own accounts, transactions,
messages, contacts and other objects.

Below are provided the fields of the customer object:

```json
{
  "id": 1234567 ,
  "state": "Active" ,
  "created": "2021-08-16T15:45:28.184+0000" ,
  "modified": "2022-06-17T15:04:31.169+0000" ,
  "state_changed": "2021-08-16T15:45:52.925+0000" ,
  "name": "My Company Pte. Ltd." ,
  "type": "Corporate" ,
  "kind": "Organization" ,
  "compliance_state": "Passed" ,
  "business_code": "f7949fc6-4951-41d0-a9ae-740ff6acd2c8"
}
```

Field details:

### state

The state of the customer. The possible values are:

* "New" - the customer has been just created.
* "Confirmed" - at least one of the customer's contact (mobile phone or email) was confirmed.
* "Active" - the customer has fulfilled their profile.

Immediately after registration a customer has the "New" state, then after confirming their mobile phone number via USSD,
the state is changed to "Confirmed". But after providing the whole and the valid information in the [profile](../profile/profiles.md)
the state is transformed to the "Active".

The customers who have states less then "Active" cannot sign any documents or payments.

### name

The full name of the customer.

### type

Possible values: Individual, Corporate.

### kind

Additional classification for certain corporate entities: Organization, Bank or Exchange.

### business_code

A portable string identifier of the customer.

### compliance_state

Possible values are:

* "Restricted" - the customer did not pass yet the identification procedure (KYC).
* "Accepted" - the identification form has been submitted by the customer
* "Pending"  - the KYC procedure has been started
* "Passed"   - the customer has been successfully passed the KYC procedure
* "Refused"  - the customer was unable to pass the KYC procedure.



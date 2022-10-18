# Multi-customer applications

Some functions can work for the current customer only. The system supports both individual
and corporate clients who are accessible via a single authorized user. If you have added
at least one corporate customer, you can switch your application between the default
individual client and the new added corporate.

1. [Retriving Current Customer](#retrieving-current-customer)
2. [Available Customers](#available-customers)
3. [Changing the Current Customer](#changing-the-current-customer)

# Retrieving Current Customer

This operation is used to retrieve the main fields of the current customer like the "name",
"state" and "type", which can be used to determine valid interaction with the customer
(like not allowing them to do something until the state is not "Active").
Please see [customer models](./models/customer.md) for more details.

### REQUEST:

```
    GET   /api/v1/customers/current
```

```bash
curl -X GET -H "Authorization: Bearer $TOKEN"  \
             $API_HOST/api/v1/customers/current
```

### RESPONSE:

```json
{
  "code": 0 ,
  "created": "2020-03-16T09:37:19.659+0000" ,
  "id": 10 ,
  "modified": "2020-07-14T15:08:03.174+0000" ,
  "name": "Customer Demo" ,
  "state": "Active" ,
  "state_changed": "2020-07-14T15:08:03.161+0000" ,
  "type": "Individual"
}
```

# Available Customers

Retrieves a list with all customers who are available for the current user.

### REQUEST:

```
    GET   /api/v1/customers
```

```bash
curl -X GET -H "Authorization: Bearer $TOKEN"  \
             $API_HOST/api/v1/customers
```

```json
[
  {
    "created": "2020-03-16T09:37:19.659+0000" ,
    "id": 10 ,
    "modified": "2020-07-14T15:08:03.174+0000" ,
    "name": "Customer Demo" ,
    "state": "Active" ,
    "state_changed": "2020-07-14T15:08:03.161+0000" ,
    "type": "Individual"
  } ,
  {
    "created": "2020-07-16T12:07:27.756+0000" ,
    "id": 779050 ,
    "kind": "Organization" ,
    "name": "Demo Company Inc." ,
    "state": "New" ,
    "type": "Corporate"
  }
]
```

# Changing the Current Customer

This operation gives you a way to change the current customer to one from the list
of available customers. After performing the operation all API function will work
with the new customer.

### REQUEST:

```
    PUT   /api/v1/customers/:id/current
```

### ARGUMENTS:

> **id** - the ID of the customer

```bash
curl -X PUT -H "Authorization: Bearer $TOKEN" \
             $API_HOST/api/v1/customers/1234567/current
```

### RESPONSE:

```json
{
  "created": "2020-07-16T12:07:27.756+0000" ,
  "id": 1234567 ,
  "kind": "Organization" ,
  "name": "Demo Company Inc." ,
  "state": "New" ,
  "type": "Corporate"
}
```

The fields are the same as above and describe the new current customer.


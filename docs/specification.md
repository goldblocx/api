# Introduction

The platform provides a very simple REST API to integrate its abilities to your own
business application. This Reference Guide gives you the information about all
available resources and endpoints.

## Using Access Token

After registering your [own application](./applications/registration.md) and receiving an access token
(see [Authentication](./authentication.md) for details) you can use it in API queries.

In accordance with the [OAuth 2 specification](https://tools.ietf.org/html/rfc6749) you need to add the special authorization header.
Here is an example for it:

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/users/roles
```

## Error Processing

In case of any API error, the response has a status 400 (Bad request) and it includes
some information about the error code, message and description.

For example:

```json
{
  "code": -1 ,
  "message": "A system error" ,
  "description": "You forgot to create a database" ,
  "error_id": "no.database.found"
}
```

Also, an appropriate HTTP status codes and JSON body are returned for specific cases like:

* "Forbidden", HTTP 403 - when the user does not have access to the resource.
* "Unauthorized", HTTP 401 - when the user is not authorized (or the access token is expired).
* "Internal Server Error", HTTP 500 - when some our error occurs on the server side.

All successful API responses have the **code** to be 0 (That means "success").
The value "-1" is mainly used for different validation errors, the value "1" means
"Just an error". The identifier "error_id" may be used to determine a concrete error.

## Pagination

Certain API endpoints may return data by portions - pages. For such endpoints, we support
two request parameters:

- **per_page** - how many results must be in a page
- **page** - the current page to return

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/transactions?per_page=10&page=2 
```

In the response, each result item has the 'total' field - the total number of expected
results.

```json
[
  {
    "total": 160 ,
    "id": 12345 ,
    "amount": 1000.00 ,
    ...
  } ,
  ...
]
```

## Sorting

Certain API endpoints support sorting by a certain field, for example, 'created'.
Here is an example how to specify the sorting - ASC('+') or DESC ('-').

```bash
# ASC by 'created'
curl -X GET -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/transactions?sort=+created

# DESC by created             
curl -X GET -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/transactions?sort=-created 

# ASC by 'created' if no sign specified
curl -X GET -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/transactions?sort=created

```

## Common Attributes

Most of the objects have some standard attributes like 'id', 'created', 'modified', 'state' and
'state_changed':

- **id** - the internal ID of the object
- **created** - the time of creation of the object
- **modified** - the time of last modification
- **stage_changed** - the time when the state was changed
- **state** - the current state of the object.

# API Reference

1. [User's Endpoints](./roles.md)
2. [Customers](./customers.md)
3. [Customer Profiles and KYC applications](./profile/profiles.md)
4. [Products](./products/products.md)
    1. [Accounts](./products/accounts.md)
    2. [Currency/Asset Exchange](./products/assets.md)
    3. [Exchange Transaction](./products/exchangetransaction.md)
5. [Money Transfer, Depositing or Withdrawing Funds](./transactions/transactions.md)
6. [Messages to/from Customers](./messages.md)
7. [Creating Own Applications](./applications/applications.md)
    1. [Setting Own Fees](./applications/fees.md)
    2. [Creating Assets/Currencies](./applications/own_assets.md)
    3. [Service Providers](./applications/providers.md)
8. [All Models and Tools](./models/models.md)
8. [Precious Metals](./products/preciousmetals.md)

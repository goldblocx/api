# Fees

Each application can set specific fees for transactions which are carried out under the application. You can set your
own list of fees if you are logged as a corporate customer inside one of your application. (see [Application](./registration.md))

1. [Creation of Fees](#creation-of-fees)
2. [Modifying Fees](#modifying-fees)
3. [Querying a Fee](#querying-a-fee)
4. [Removing a Fee](#removing-a-fee)
5. [Specifying an Account for Fees](#specifying-an-account-for-fees)


# Creation of Fees

To create a new fee for your application, you need to specify the fields like 'algorithm', 'value', 'fee_code' and in
some cases 'asset_id'. The possible values for the 'algorithm' field are 'percent' or 'fixed' which means the fee value is
calculated as a percent from the sum of a transaction or just as fixed amount of money to withdraw.

In the case of the 'fixed' type the field 'asset_id' must be set to understand which currency to use
for the fee. The field 'fee_code' means the operation where the fee is applicable. Currently, we support the following
operations: 'Transfer' (when the fee occurs during sending an asset from one client to another) and 'Exchange' (when
the fee occurs during conversion of some assets).

### REQUEST:
    POST /api/v1/fees
### ARGUMENTS:

```
    The model: {"fee_code" : "...", "algorithm" : "...", "value": "..." , "asset_id" : "..."}
```

### EXAMPLE

```bash
TOKEN="put your access token is here"
MODEL='{"fee_code" : "Transfer", "algorithm" : "fixed", "value": 12.00 , "asset_id" : "USD"}'
curl -X POST -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/fees -d $MODEL
```

### RESPONSE:

```javascript
{
    "code":0,
    "id":6000,
    "created":"2016-04-04T07:50:39.097+0000",
    "asset_id":"USD",
    "fee_code":"Transfer",
    "algorithm":"fixed",
    "value":12.00
}
```

The important field in this response is the identifier 'id' which can be used to uniquely identify a fee. This value
is used in further operations (like modifying, removing, etc.).


# Modifying Fees

You can modify all fields of a fee providing new values for the fee model. The only difference from the creation of
fees is the 'id' field in the body of modification requests.

### REQUEST:
    PUT /api/v1/fees
### ARGUMENTS:

```
    The model: {"fee_code" : "...", "algorithm" : "...", "value": "..." , "asset_id" : "...", 'id': 6000 }
```

### EXAMPLE

```bash
TOKEN="put your access token is here"
MODEL='{"fee_code" : "Transfer", "algorithm" : "percent", "value": 0.02 , "id" : 6000 }'
curl -X PUT -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/fees -d $MODEL
```

### RESPONSE:

```javascript
{
    "code":0,
    "id":6000,
    "created":"2016-04-04T07:50:39.097+0000",
    "fee_code":"Transfer",
    "algorithm":"percent",
    "value":0.02
}
```

The example above sets the fee 2% for all transfers between two clients.


# Querying a Fee

Use this query to get details about a concrete fee.

### REQUEST:
    GET /api/v1/fees/:id
### ARGUMENTS:

    id - the identifier of the fee

### EXAMPLE

```bash
TOKEN="put your access token is here"
curl -X GET -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/fees/6000
```

### RESPONSE:

```javascript
{
    "code":0,
    "id":6000,
    "created":"2016-04-04T07:50:39.097+0000",
    "fee_code":"Transfer",
    "algorithm":"percent",
    "value":0.02
}
```


# Removing a Fee

Use this query to remove some fee which is no required anymore.

### REQUEST:
    DELETE /api/v1/fees/:id
### ARGUMENTS:

    id - the identifier of the fee

### EXAMPLE

```bash
TOKEN="put your access token is here"
curl -X DELETE -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/fees/6000
```

### RESPONSE:

```javascript
{
    "code":0,
    "id":6000,
    "created":"2016-04-04T07:50:39.097+0000",
    "fee_code":"Transfer",
    "algorithm":"percent",
    "value":0.02
}
```

The response contains information about the deleted fee.

# Specifying an Account for Fees

By using this query you can set one of your accounts as an account for gaining fees. You can open such account
for each currency.

### REQUEST:
    PUT /api/v1/fees/account/:id
### ARGUMENTS:

    id - the identifier of the account to set (see [Account](../products/accounts.md)

### EXAMPLE

```bash
TOKEN="put your access token is here"
curl -X PUT -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/fees/account/4750
```

### RESPONSE:

```javascript
{
    "description":"Current", 
    "id":4750,
    "balance": 1117.97000, 
    "type":"Common", 
    "currency": {"description": "USD","value": "USD"}
}
```

The response contains the data about the account which has been set. 

*Be aware, if you have not set an account for some asset (currency), any corresponding transactions with this fee will
not be unsuccessful.*

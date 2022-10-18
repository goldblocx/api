# Number of Draft Transactions

Returns a number of **uncompleted** (Draft) transactions for the current customer.

### REQUEST:

```
    GET     /api/v1/transactions/notcompleted/count
```

### EXAMPLE:

```bash
curl -X GET -H "Accept: application/json" \
            -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/transactions/notcompleted/count
```

### EXAMPLE of RESPONSE:

```
2
```

The result is just a number.

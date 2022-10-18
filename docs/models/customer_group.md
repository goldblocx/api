# Customer Group

Customer groups are a way to group certain customer-related products parameters,
for example, fees.

A typical customer group object has the following structure:

```json
{
  "id": 1234567 ,
  "name": "VIP" ,
  "fees": [
    {
      "id": 12345 ,
      "value": 0.00 ,
      "fee_code": "Transfer"
    } ,
    {
      "id": 12346 ,
      "value": 0.00 ,
      "fee_code": "Exchange"
    }
  ]
}
```

# Customer Groups API

There are several API endpoints for operations with customer groups.

### Get all groups available for the current provider

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/customers/groups
```

### Creating a new group

```bash
MODEL='{
  "name" : "VIPs"
}'

curl -X POST -H "Authorization: Bearer $TOKEN" \
             -d $MODELS \
             $API_HOST/api/v1/customers/groups
```

### Deleting a certain customer group

```bash
curl -X DELETE -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/customers/groups/:id
```

> **id** - the ID of the customer group object

The group must be empty, i.e. not to have fees, instruments and related customers.

### Modifications of the group

```bash
MODEL='{
  "id" : 1234567,
  "name" : "Super VIPs"
}'

curl -X PUT -H "Authorization: Bearer $TOKEN" \
             -d $MODELS \
             $API_HOST/api/v1/customers/groups/:id
```

Actually, we allow to modify the name of the group here only.

### Retrieving the group by its ID

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/customers/groups/:id
```

> **id** - the ID of the customer group object

### Adding the customer to the given group

```bash
curl -X PUT -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/groups/:group/customers/:customer
```

> **group** - the ID of the group object
>
> **customer** - the ID of the customer

### Deleting the given customer from the group

```bash
curl -X DELETE -H "Authorization: Bearer $TOKEN" \
               $API_HOST/api/v1/groups/:group/customers/:customer
```

> **group** - the ID of the group object
>
> **customer** - the ID of the customer

### Retrieving groups of the given customer

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/customers/:id/groups
```

> **id** - the ID of the customer

### Retrieving customers of the given groups

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/groups/:id/customers?per_page=25
```

> **id** - the ID of the group

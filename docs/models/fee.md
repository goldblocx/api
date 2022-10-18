# Fee Model

Fees allow to specify parameters and the algorithm of how to charge the customer
for certain services or operations.

Here are two examples of the fee model.

The first manages the 1.2% fee for all transfers between customers.

```json
{
  "algorithm": "percent" ,
  "fee_code": "Transfer" ,
  "id": 1234567 ,
  "value": 1.2
}
```

The second gives an example of a fixed 0.02 USD fee for all currency conversions.

```json
{
  "algorithm": "fixed" ,
  "asset_id": "USD" ,
  "fee_code": "Exchange" ,
  "id": 7654321 ,
  "value": 0.02
}
```

### algorithm

There are several predefined algorithms: 'percent', 'fixed', 'exchange', 'mixedbank' and
'mixedcard'. The percent algorithm expects a percent value in the 'value' field and
calculates the fee as percent from the amount of the transactions. The fixed algorithm
withdraws some fixed value in the currency given in the 'asset_id' field.

Depending on the installation of the platform, there can be other more tricky algorithms
for fees.

### fee_code

The concrete location of the fee. Currently, we support custom fees with the following codes:

* 'Transfer' - a fee for transactions between customers
* 'Exchange' - a fee for all conversions.
* 'GST' - a fee is a GST tax charging.

### asset_id

It is relevant in the case when the algorithm field is 'fixed'. Here you can specify the currency (asset)
that will be used for withdrawing the fee.

### value

Just a value of the fee: a percent value (for example, 1.2 or 5) or a concrete value
25.00 or 0.05. Please bear in mind that a percent value 25% should be set as 0.25.

### value_type

The type of the value: PERCENT or ASSET (if the fee is charged in certain assets/currencies).

### immutable

true, if it is a system fee and cannot be modified.

### additional_value

Some fee algorithms use this field for their needs.

### min_value and max_value

Sometimes fees may have the min or max value and the fee algorithm use these values
to control the value limitation.

### group

A reference to a group if this fee must be applied to certain groups of customers only.
Please check the [customer groups](./customer_group.md) section for details.

# Fee API

### Get Available Fees

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/fees
```

### Get a concrete fee

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/fees/:id
```

### Creating and modifying a fee

```bash
# Creating
MODEL='{
  "algorithm" : "percent",
  "fee_code" : "Tranfer",
  "value" : 0.10,
  "max_value" : 100,
  "min_value" : 10 
}'

curl -X POST -H "Authorization: Bearer $TOKEN" \
             -d $MODELS \
             $API_HOST/api/v1/fees
             
# Modifying
MODEL='{
  "id" : 12345,
  "algorithm" : "percent",
  "fee_code" : "Tranfer",
  "value" : 0.20,
  "max_value" : 200,
  "min_value" : 20 
}'

curl -X PUT -H "Authorization: Bearer $TOKEN" \
             -d $MODELS \
             $API_HOST/api/v1/fees/:id             
```

### Deleting a fee

```bash
curl -X DELETE -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/fees/:id
```

There will be the fee's model before deleting.

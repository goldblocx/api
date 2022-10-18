# Address Model

The address is the location of individual or corporate entities.

```json
{
  "address": "1 George Street, Tower B, #10-01" ,
  "city": "Singapore" ,
  "country": {
    "value": "SG" ,
    "description": "Singapore"
  } ,
  "postal_code": "049145" ,
  "type": "Legal"
}
```

### address

The rest part of the address like the name of the street, the number of the building, the office, etc.
It is provided as a single string.

### city

The name of the city

### country

A reference to the country of the address. Please refer to [the country directory](./country.md)
for details.

### postal_code

The postal code of the address.

### type

The type of the address. Supported values: 'Legal', 'Actual', 'Shipment'

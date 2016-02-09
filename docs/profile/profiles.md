# Customer Profile

Copernicus Gold supports both *individual* and *corporate* customers. Each of them has their own profile model containing
the appropriate fields.

1. [Individual Customer Model](./individuals.md)
2. [Profile Directories Used in the Model](./profile_directories.md)

# Retrieving Customer Profile

Returns the profile model for the current customer
The function returns the data for the current authorized customer which must be an individual person (not a corporate).

### REQUEST:
       
       GET    /api/v1/customers/individual/data

### ARGUMENTS:
       
       none

### EXAMPLE

```bash
TOKEN="your access token here"
curl -X  -H "Authorization: Bearer $TOKEN" https://api.projectdgc.com/api/v1/customers/individual/data
```
 
### RESPONSE:

```javascript
{
    "code": 0,
    "first_name": "Alexey",
    "full_name": "Romanchuk Alexey Petrovich",
    "id": 652450,
    ...
}
```

The result is a customer model. In the case if the current customer doesn't have any profile data the result will 
be  ```{ "code" : 0  }```. The identifier ("id") must be used to edit the profile (see PUT below). 

# Submitting or Editing Customer Profile

This operation performs creation of new profile data based on the aforementioned model specified in the request. 
In case of editing must be used the PUT method. In this case the identifier ("id") must be included in the request body.

## REQUEST:

       POST | PUT    /api/v1/customers/individual/data

### ARGUMENTS:

      none

### EXAMPLE

```bash
TOKEN="your access token here"
curl -X POST -H "Authorization: Bearer $TOKEN" -d {"birth_date" : "...", "sex" : {...}, ..."} https://api.projectdgc.com/api/v1/customers/individual/data
```

### RESPONSE:

```javascript
{
    "code"   : 0,
    "birth_date": "1978-11-14",
    "id": 652450,
    ...
}
```

The operation returns the customer model. In case of creation a new profile this method also returns the identifier for
the profile.
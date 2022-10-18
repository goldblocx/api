# Avatars

The avatar is a picture or a snapshot uploaded by user and is shown in applications
for the user's profile. Actually, the avatar is just a thin wrapper around its
uploaded file.

```json
{
  "file": {
    ...
  } ,
  "customer_id": 1234567 ,
  "base_64": "..."
}
```

### file

It is a [file model](./file.md) for a preliminary uploaded file.

### customer_id

The identifier of the current customer.

### base_64

The base64 encoded avatar data if the avatar was request as such data.

## Avatar API

### Creating a new avatar

```bash
MODEL='{
  "file" : {
    "id" : 12345,
    "mime_type": "image/jpeg"
  }
}'

curl -X PUT -H "Authorization: Bearer $TOKEN"  \
            -d $MODEL \
            $API_HOST/api/v1/customers/:id/avatar
```

> ***id*** - the ID of the customer.

### Get Avatar's Data

Downloading the avatar's data as bytes.

```bash
curl -X GET -H "Authorization: Bearer $TOKEN"  \
            $API_HOST/api/v1/customers/:id/avatar
```

> ***id*** - the ID of the customer.

### Get Avatar's Model with embedded base64 data

Downloading the avatar's data as bytes.

```bash
curl -X GET -H "Authorization: Bearer $TOKEN"  \
            $API_HOST/api/v2/customers/:id/avatar
```

> ***id*** - the ID of the customer.


The result will be something like this:

```json
{
  "code": 0 ,
  "file": {
    "mime_type": "image/jpeg" ,
    "original_file_name": "avatar.jpg" ,
    "size": 53960
  } ,
  "customer_id": "5131200" ,
  "base64": "....."
}
```

### Removing Avatars

Removes the avatar for the given customer.

```bash
curl -X DELETE -H "Authorization: Bearer $TOKEN"  \
            $API_HOST/api/v1/customers/:id/avatar
```

> ***id*** - the ID of the customer.
> 

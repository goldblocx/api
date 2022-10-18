# File Model

Files can be uploaded by customers when chatting with the support service or
the files can be some documents participating in the KYC procedure or
other processes.

A typical model for an uploaded file looks like this:

```json
{
  "created": "2020-07-03T09:50:12.503+0000" ,
  "id": 1234567 ,
  "mime_type": "image/jpeg" ,
  "modified": "2020-07-03T09:50:12.523+0000" ,
  "original_file_name": "my_picture.jpg" ,
  "size": 30323 ,
  "state": "Active"
}
```

Fields:

### mime_type

The mime type which describes the nature of the file.

### original_file_name

The original name of the file before it was uploaded to the platform.

### size

The size of the file in bytes.

# Files API

## Uploading a file

```bash
curl -X POST -H 'Content-Type: multipart/form-data' \
             -F filex=@sample.txt \
             $API_HOST/api/v1/files
```

Here is the sample.txt - the path to the file to be uploaded.
The result is the file model similar to the described above.

## Downloading the File

```bash
curl -X GET -H 'Accept: application/octet-stream' \
            -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/files/:id 
```

The result is a stream with the file opened for downloading.

## Obtain the file model by ID

In case if you need to get details of the file you can query:

```bash
curl -X GET -H 'Accept: application/json' \
            -H 'Content-Type: application/json' \
            -H "Authorization: Bearer $TOKEN"  \
            $API_HOST/api/v1/files/:id
```

> **id** - the ID of the file.

## Get the content of the file as a base64-string

```bash
curl -X GET -H "Authorization: Bearer $TOKEN"  \
            $API_HOST/api/v1/files/:id/base64
```

The result will be a string "...." with the base64-encoded data.

## Removing a file

```bash
curl -X DELETE -H "Authorization: Bearer $TOKEN"  \
               $API_HOST/api/v1/files/:id
```

## Operations with files for certain customers

If you need to download or upload a file for a certain customer, please use
these operations:

### Get list of files for the given customer

```bash
# All files
curl -X GET -H "Authorization: Bearer $TOKEN"  \
            $API_HOST/api/v1/customers/:id/files?page=0&per_page=25
            
# All files of the given subtype
curl -X GET -H "Authorization: Bearer $TOKEN"  \
            $API_HOST/api/v1/customers/:id/files?subtype=KYC            
```

> **id** - the ID of the customer

### Uploading a file for a certain customer

```bash
curl -X POST -H 'Content-Type: multipart/form-data' \
             -F filex=@sample.txt \
             $API_HOST/api/v1/customers/:id/files
```

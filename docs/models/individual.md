# Individual Model

This model is used for description of individual people.

```json
{
  "id": 1234567 ,
  "state": "Active" ,
  "state_changed": "2021-08-16T15:41:07.079+0000" ,
  "customer": {
    "id": 12345678 ,
    "state": "Active" ,
    "created": "2021-08-15T12:24:38.768+0000" ,
    "name": "Romanchuk Alexey" ,
    "type": "Individual" ,
    "compliance_state": "Passed" ,
    "business_code": "d2121986-b0c5-4c14-9616-afcde8ec4a0d"
  } ,
  "full_name": "Romanchuk Alexey" ,
  "first_name": "Alexey" ,
  "middle_name": "Petrovich" ,
  "last_name": "Romanchuk" ,
  "gender": {
    "description": "Male" ,
    "value": "Male"
  } ,
  "birth_date": "1978-11-14T00:00:00.000+0000" ,
  "nationality": {
    "description": "Ukraine" ,
    "value": "UA"
  } ,
  "document_type": {
    "description": "Passport" ,
    "value": "Passport"
  } ,
  "current_address": {
    "id": 226200 ,
    "country": {
      "description": "Kyrgyzstan" ,
      "value": "KG"
    } ,
    "city": "Bishkek" ,
    "type": "Legal"
  } ,
  "document_models": [
    {
      "id": 12345 ,
      "state": "Active" ,
      "created": "2021-08-20T13:04:20.720+0000" ,
      "modified": "2021-08-20T13:04:23.435+0000" ,
      "mime_type": "image/jpeg" ,
      "original_file_name": "D3257985-2C58-4C9B-963E-FF4DE18ACFFE.jpeg" ,
      "size": 3303214
    }
  ] ,
  "residential_models": [
    {
      "id": 54321 ,
      "state": "Active" ,
      "created": "2021-08-20T13:05:49.281+0000" ,
      "modified": "2021-08-20T13:05:49.644+0000" ,
      "mime_type": "application/pdf" ,
      "original_file_name": "Proof_of_address_from_bank.pdf" ,
      "size": 383472
    }
  ] ,
  "email": {
    "state": "Confirmed" ,
    "kind": "Main" ,
    "type": "Email" ,
    "value": "x@mail.com"
  } ,
  "nick_name": "Alexey" ,
  "photo_model": {
    "id": 1234567 ,
    "state": "Active" ,
    "created": "2022-08-20T13:05:49.281+0000" ,
    "modified": "2022-08-20T13:05:49.644+0000" ,
    "mime_type": "image/jpeg" ,
    "original_file_name": "D23123.jpeg" ,
    "size": 15234
  }
}
```

### customer

A reference to the [customer](./customer.md) that is associated with the given individual

### birth_date

The birthdate of the person.

### current_address

The address of residence of the person. Please refer to [the address model](./directories/address.md) for
details on its structure.

### document_number

The number of the identification document of the person.

### document_type

The type of the identification document. Please refer to [the document types directory](./directories/documents.md)
for details.

### document_issue_date

The date when the document was issued.

### document_expire_date

The date when the document will expire

### fatca

The value is true if the person HAS any relations to the US residence. The taxation in accordance
with Foreign Account Tax Compliance Act (FATCA).

### pep

If is set as true, it means the person is a Politically Exposed Person (PEP).

### first_name, middle_name, last_name and full_name

Different parts of the name including the full name of the individual.

### nick_name

A personal name that the customer can set for themselves for communications.

### nationality

The citizenship of the person. Should be a value from the [country directory](./directories/country.md).

### gender

Here must be one of the values from [the gender directory](./directories/gender.md).

### industry (optional)

A value from the [industry directory](./directories/directory.md).

### occupation  (optional)

A value from the [occupation directory](./directories/directory.md).

### document_models

Here is an array of the file models of [uploaded files](./file.md) with photographs
of the identification documents (passport, ID card).

### residential_models

Here are the array of file model of uploaded files with scanned documents proving
the residence of the person.

### photo_model

Here is the ID of an uploaded file with the photograph of the person (selfie).
To improve the security of the snapshot we usually ask the person to provide
on this photo a paper with the drawn individual code.

This code is changed daily and can be obtained as follows:

```bash
curl -x GET -H "Authorization: Bearer $TOKEN"  \
            $API_HOST/api/v1/identification/code
```

The result will be a plain string with quotes, e.g. "3385"

# Corporate Data Model

The corporate data model represents an object that provides full details on the given corporate entity like
the registration date, the legal address, the business activity, etc.

```json
{
  "id": 12345678 ,
  "customer": {
    "id": 12345678 ,
    "state": "Active" ,
    "created": "2021-08-16T15:45:28.184+0000" ,
    "modified": "2022-06-17T15:04:31.169+0000" ,
    "state_changed": "2021-08-16T15:45:52.925+0000" ,
    "name": "My Company Pte. Ltd." ,
    "type": "Corporate" ,
    "kind": "Organization" ,
    "compliance_state": "Passed" ,
    "business_code": "f7949fc6-4951-41d0-a9ae-740ff6acd2c8"
  } ,
  "name": "My Company Pte. Ltd." ,
  "email": "mail@mail.com" ,
  "registration_number": "202118659R" ,
  "registration_date": "2020-06-06T00:00:00.000+0000" ,
  "registration_address": {
    "id": 1234567 ,
    "postal_code": "051531" ,
    "country": {
      "description": "Singapore" ,
      "value": "SG"
    } ,
    "city": "Singapore" ,
    "address": "531a Upper Cross Street #04-95, Hong Lim Complex" ,
    "type": "Legal"
  } ,
  "owner_id": 12345678 ,
  "affiliates": [
    {
      "id": 87654321 ,
      "state": "Active" ,
      "full_name": "Romanchuk Alexey" ,
      "first_name": "Alexey" ,
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
      "current_address": {
        "id": 12345 ,
        "country": {
          "description": "Kyrgyzstan" ,
          "value": "KG"
        } ,
        "type": "Legal"
      } ,
      "phone_number": "....." ,
      "is_organization_management": true ,
      "is_director": true ,
      "owner_id": 87654321
    }
  ] ,
  "is_authorized": true
}
```

### customer

The linked [customer object](./customer.md).

### email

The primary business email address which is utilized also as the main address for
receiving payments.

### name

The official name of the company.

### owner_id

The ID of the linked [customer object](./customer.md).

### registration_address

The reference to the legal address of this corporate entity. For more details on the structure of this
field, please refer to [the address directory](./directories/address.md).

### registration_date

The date of the official registration of the company.

### registration_number

The government registration code of the company.

### corporate_phone_number

The phone number of the company. It is used just for information and cannot be used for receiving payments.

### corporate_type

The type of the corporate entity. The full list of the values can be obtained from
the API endpoint:

```bash
curl -x GET -H "Authorization: Bearer $TOKEN"   $API_HOST/api/v1/directory/CORPORATE_TYPES
```

### biz_files_models

The models of uploaded files (see [file models](./file.md)) with the details of company's
business profile (BizFile).

### company_constitution_models

The models of uploaded files with the Company Constitution or Memorandum of Association
and Articles of Association.

### other_documents_models

The models of other documents that can be used for the identification of this corporate entity.
For example, these can be the documents to confirm the authority of the head of
the organization and the business activity.

### affiliates

A list of people who have a permission to manage the company. The structure of this field is almost the same
as [for individuals](./individual.md) with several additional fields:

```json
{
  ...
  "is_beneficial": false ,
  "is_director": true ,
  "is_organization_management": true ,
  "is_partner": false ,
  "phone_number": "..." ,
  ...
}
``` 

The fields 'is_beneficial', 'is_director', 'is_partner' describe the role of
the individual in the company. The 'is_organization_management' field gives a permission
to manage the company's accounts, i.e. make payments.

The 'phone_number' field allows to provide the mobile phone number of the person,
which may be used to connect the person to the company's access list automatically
if the person has a registered account in the system for this phone number.

### is_authorized

This field is true when the current authorized user has the full management
access to the company.


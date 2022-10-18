# Application Concept

Applications are a way to build your own services using the platform and its abilities
to store and to carry out financial transactions using different electronic assets
including those you create for your own aims. The first application must be created
in the platform's UI, e.g. in [the web application](./registration.md).

When you create a new application for the first time, the platforms creates a
[**provider**](../models/provider.md) - it is an entity that allows you to hold
and group you own settings, fees, assets (currencies) and other objects. Different
applications can be linked to different providers and, thus, you can create
several independent services.

1. [Creating Applications](#creating-applications)
2. [Removing Applications](#removing-applications)
3. [Modifying an Application](#modifying-applications)
4. [Obtaining Application Details](#obtaining-application-details)
5. [Obtaining All Applications](#obtaining-all-applications)
6. [Obtaining the Application of a Provider](#obtaining-by-provider)

You can see some examples for these operations:
[application_test](../../tests/applications_test.sh).

# Creating Applications

This operation allows you to create an application and to receive *app_id* and *app_secret* from
the server which can be used in the OAUTH2 [authentication procedure](../authentication.md).

To create an application you need to be logged in as a corporate customer. Please use
the [change customer endpoint](../customers.md/#changing-the-current-customer) to switch to
your corporate entity.

### REQUEST:

```
POST /api/v1/applications 
```

### BODY:

```json 
{
  "redirects" : ["..."], 
  "provider": {
    "id": ...
  } 
}
```

(optional) The 'redirects' array must be filled with an url in the case when you use
the web authorization flow, and you need to provide a callback url to make a redirection
from the authorization server back to your application.

(optional) The 'provider' is a reference to [the provider object](../models/provider.md).
This field is used when you need to link the application to the same provider as some
other your application has. If applications have the same provider, they may have same
settings like fees and products.

### EXAMPLE

```bash
MODEL='{
  "redirects" : [
    "http://localhost:8080"
  ] 
}'

curl -X POST -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/applications \
             -d $MODEL
```

### RESPONSE:

```json
{
  "code": 0 ,
  "created": "2019-04-03T14:06:58.620+0000" ,
  "app_id": "3a16d63129c94e7d93b0d0bb6a898691" ,
  "app_secret": "18fa73f6ab8c45779c1c66de6a6ede1d" ,
  "grant_types": [
    "authorization_code" ,
    "password" ,
    "refresh_token"
  ] ,
  "redirects": [
    "http://localhost:8080"
  ] ,
  "provider": {
    ...
  }
}
```

Now, you can provide for your clients the ability to login via your own application
using the given *app_id* and *app_secret*. See, for example,
[this test](../../tests/applications_test.sh)

Additional information on the application object can be found [here](../models/application.md)

# Removing Applications

Removes the specified application.

### REQUEST:

```
    DELETE /api/v1/applications/:app_id
```

### ARGUMENTS:

    app_id - the identifier of the application

### EXAMPLE

```bash
APP_ID='3a16d63129c94e7d93b0d0bb6a898691'

curl -X DELETE -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/applications/$APP_ID
```

### RESPONSE:

```json
  {
  "code": 0 ,
  "created": "2016-04-03T14:06:58.620+0000" ,
  "app_id": "3a16d63129c94e7d93b0d0bb6a898691" ,
  "grant_types": [
    "authorization_code" ,
    "password" ,
    "refresh_token"
  ] ,
  "redirects": [
    "http://localhost:8080"
  ] ,
  "provider": {
    ...
  }
}
```

In the response you can see the model of the application that was removed.

# Modifying Applications

You can also modify application's attributes using the PUT request with the same model as for
POST requests. The only difference is when you provide an *app_secret* value in the model you can
change the application's password.

### REQUEST:

```
    PUT /api/v1/applications/:app_id
```    

### ARGUMENTS:

```
    app_id - the identifier of the application
```

### BODY:

```
    The model: { 
        "redirects" : ["http://localhost:8080"],
        "app_secret" : "...",
        "app_id": "..."
    }
```

(optional) The 'redirects' array must be filled with an url in the case when you
use the web authorization flow and need to provide a callback url to make a redirection
from the authorization server back to your application.

(optional) The 'app_secret' is a new password for the application.

### EXAMPLE

```bash
MODEL='{ 
    "redirects" : ["http://localhost:8080", "https://www.com" ], 
    "app_secret": "xxx" 
}'
APP_ID=3a16d63129c94e7d93b0d0bb6a898691

curl -X PUT -H "Authorization: Bearer $TOKEN" \
            -d $MODEL \
            $API_HOST/api/v1/applications/$APP_ID           
```

### RESPONSE:

```json
  {
  "created": "2019-04-03T14:06:58.620+0000" ,
  "app_id": "3a16d63129c94e7d93b0d0bb6a898691" ,
  "grant_types": [
    "authorization_code" ,
    "password" ,
    "refresh_token"
  ] ,
  "redirects": [
    "http://localhost:8080" ,
    "https://www.com"
  ]
}
```

As you can mention there is no app\_secret field in the response.

# Obtaining Application Details

Returns the information about a concrete application by its identifier.

### REQUEST:

```
    GET /api/v1/applications/:app_id
```

### ARGUMENTS:

    app_id - the identifier of the application

### EXAMPLE

```bash
APP_ID='3a16d63129c94e7d93b0d0bb6a898691'

curl -X GET -H 'Accept: application/json' \
            -H 'Content-Type: application/json' \
            -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/applications/$APP_ID
```

### RESPONSE:

```json
  {
  "created": "2019-04-03T14:06:58.620+0000" ,
  "app_id": "3a16d63129c94e7d93b0d0bb6a898691" ,
  "grant_types": [
    "authorization_code" ,
    "password" ,
    "refresh_token"
  ] ,
  "redirects": [
    "http://localhost:8080" ,
    "https://www.com"
  ] ,
  "provider": {
    ...
  }
}
```

In the response you can see the [model of the application](../models/application.md).

# Obtaining All Applications

Returns a list of all applications available for the current customer who must be a corporate entity.
Please use the [change customer endpoint](../customers.md/#changing-the-current-customer) to switch to
your corporate entity.

### REQUEST:

```
    GET /api/v1/applications
```    

### EXAMPLE

```bash
curl -X GET -H 'Accept: application/json' \
            -H 'Content-Type: application/json' \
            -H "Authorization: Bearer $TOKEN" \
            $HOST/api/v1/applications
```

### RESPONSE:

```json
[
  {
    "created": "2019-04-03T14:06:58.620+0000" ,
    "app_id": "3a16d63129c94e7d93b0d0bb6a898691" ,
    "grant_types": [
      "authorization_code" ,
      "password" ,
      "refresh_token"
    ] ,
    "redirects": [
      "http://localhost:8080" ,
      "https://www.com"
    ] ,
    "provider": {
      ...
    }
  } ,
  {
    "created": "2019-04-06T08:16:39.648+0000" ,
    "app_id": "e56800d31b294181851e504e4f4e25db" ,
    "grant_types": [
      "authorization_code" ,
      "password" ,
      "refresh_token"
    ] ,
    "redirects": [ ] ,
    "provider": {
      ...
    }
  }
]  
```

# Obtaining by Provider

Returns the list of all applications belonging to a concrete provider. Please refer to
[the provider object description](../models/provider.md) for more information on providers.

### REQUEST:

```
    GET /api/v1/applications/:id/provider
```

### ARGUMENTS:

    id - the ID of the provider

### EXAMPLE

```bash
PROVIDER=1234567

curl -X GET -H 'Accept: application/json' \
            -H 'Content-Type: application/json' \
            -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/applications/$PROVIDER/provider
```

### RESPONSE:

```json
[
  {
    "created": "2016-04-03T14:06:58.620+0000" ,
    "app_id": "3a16d63129c94e7d93b0d0bb6a898691" ,
    "grant_types": [
      "authorization_code" ,
      "password" ,
      "refresh_token"
    ] ,
    "redirects": [
      "http://localhost:8080" ,
      "https://www.com"
    ] ,
    "provider": {
      ...
    }
  } ,
  {
    "created": "2016-04-06T08:16:39.648+0000" ,
    "app_id": "e56800d31b294181851e504e4f4e25db" ,
    "grant_types": [
      "authorization_code" ,
      "password" ,
      "refresh_token"
    ] ,
    "redirects": [ ] ,
    "provider": {
      ...
    }
  }
]  
```

# List of Public Applications

Returns the list of available public applications. Public applications are
available for selection by end users from the public directory. For example, if
you need to provide several apps that have different features in a single mobile application.

### REQUEST:

```
    GET /api/v1/applications/preloaded
```

### EXAMPLE

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/applications/preloaded
```

### RESPONSE:

```json
[
  {
    "app_id": "3a16d63129c94e7d93b0d0bb6a898691" ,
    "applciation_name": "Magic App"
  } ,
  {
    "app_id": "8dffbab98979879a99aa898989898ab7" ,
    "applciation_name": "Lending App"
  }
]  
```

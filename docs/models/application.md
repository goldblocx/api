# Application Model

An application is a developer's endpoint to connect the platform. Applications allow
to divide the platform's objects onto several pieces to provide different logic for
concrete business tasks. For example, the platform supports several currencies,
but you can restrict your application to use just only one currency if it is necessary.
Also, applications can be mobile, web and others.

Here is the full description of the model's fields:

```json
{
  "app_id": "63a8f7305a6d468f8c45620ca58c7cf2" ,
  "app_secret": "topsecret" ,
  "application_name": "My Good Application" ,
  "grant_types": [
    "authorization_code" ,
    "refresh_token" ,
    "password"
  ] ,
  "provider": {
    ...
  } ,
  "redirects": [
    "https://my.company.ltd/login"
  ]
}
```

Fields:

### app_id

The unique identifier of the application. It's generated when the application is created.
Then it is used in all application-related queries.

### app_secret

The application's password. Please refer to the [authentication section](../authentication.md)
in order to see example of its usage in the OAuth2 authentication process.
It is generated and appears just only once when the application is created, but it can be changed
(see, [applications](../applications/applications.md)).

### application_name

The human-readable name of the application that can be available for your customers.

### grant_types

Provides the information on supported grant types in accordance with the 'OAuth2' specification.
The **authorization_code** value means the application can use the Authentication Code Flow authorization
with a redirection to the authentication server and returning to the application url (the redirect url).
The **password** value means the application can use Resource Password Flow.
The **refresh_token** denotes a support of token refreshing.

### redirects

An url which the authentication server uses in order to return to the application.
This option is necessary for the *grant_types=authorization_code*.

### provider

This field is a reference to the [provider model](./provider.md). A provider is
an internal entity which is used for managing the parameters of applications like fees.
Each application belongs to some parameters. If no provider is specified when creating
an application, then a new provider is created. 

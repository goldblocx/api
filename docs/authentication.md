# General Concept

The authentication in Copernicus Gold is based on [OAuth 2 protocol](https://tools.ietf.org/html/rfc6749) and provides two 
main abilities to obtain an access token: *the authorization code flow* (mostly used in web applications) and 
*the resource password flow* (usually used in the applications which are not able to work with html view, for instance, mobile applications).

First of all, you need app\_id and app\_secret values which are unique for your application. If you have a corporate
account in Copernicus Gold (**CG**), you can create your own CG application and obtain a pair app\_id/app\_secret. 
For test purposes you can use the following details:
> app\_id = testapp ,  app\_secret = secret.

The CG authentication cycle has a one principal distinction from other applications: the authentication 
is based on usage of USSD service which interacts with your final customer as a secondary authentication factor.
(We could send SMS messages but decided to switch to more secured USSD messages).

# Authentication Code Flow

This scenario is generally used in web applications because it requires interactive communication with the authentication
server and browser redirections. To start the flow you need to configure a valid redirect_url parameter for your application.



# Resource Password Flow

The main difference between this flow and the previous one is absence of interaction inside of browser. But still this
authentication scheme requires at least two http requests to get the access token. The first one performs checking
the provided phone number and sends an one-time password (the verification code) to the phone, which is required for 
further authentication.

You need:

### Querying a verification code
```bash
curl -X PUT -d '{"login":"79122437136"}'  https://testapi.copernicusgold.com/api/v1/otp
```

The generated password will be sent to the specified phone number as a USSD message. After retrieving the code it can be used
to obtain an access token from the authorization server. You need the following request:

### Obtaining a token
```bash
BASIC=base64("app_id:app_secret")
curl -X POST -H "Authorization: Basic $BASIC" -d "grant_type=password&username=79122437136&password=1234&scope=full" https://testapi.copernicusgold.com/auth/oauth/token
```

Here the 'username' is the user's mobile phone number and the 'password is the one-time password sent to you above. 
The example above will return something like this:

```javascript
{ "access_token":"06935b2e-6639-4b49-8c8a-71452082a420","token_type":"bearer",
  "refresh_token":"c01b926a-cf78-4b43-be92-5fe21ef712d0","expires_in":1209599,
  "scope":"full","client_id":"testapp"}
```

The provided access\_token will work during the next 1209600 seconds (2 week) and will expire after. By using the refresh\_token
you can receive a new access_token. The expiration time of refresh_token is generally much longer than for the 
access\_token (1 month to be exact).
Use the following query to get a new access token by the refresh\_token:

```bash
REFRESH=c01b926a-cf78-4b43-be92-5fe21ef712d0
curl -X POST -d "grant_type=refresh_token&client_id=testapp&client_secret=secret&refresh_token=$REFRESH" https://testapi.copernicusgold.com/auth/oauth/token
```

The result will be the same as above in the case of receiving the first access token.

**Important**

*The provided request gives you the tokens immediately but in the same time it sends a specific USSD menu to the specified 
mobile phobe number and the user should enter the PIN code to get finally access to CG. 
This PIN code is always set during the initial registration in the system and the user knows it. 
If the user tries to close the menu, it will be impossible to complete the authentication*.
 
# Working With the Token

Once you have got the access token you can invoke an API operation as http query providing the token value in the headers of the query. 
For example:
```bash
TOKEN=06935b2e-6639-4b49-8c8a-71452082a420
curl -X GET -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/users/roles
```

The last example will return something like 'ROLE\_USER'. But if a user didn't complete the authentication process 
by entering the PIN code in USSD menu, this 'roles' query would return a role like 'ROLE\_EXPECT_PASSWORD' instead of 'ROLE\_USER'.
Also without entering the PIN code all the API functions would return the **403 Forbidden Error** because the authentication 
was not completed yet.
 
# Mobile Applications - the specific logins

For a mobile application we can use more simple authentication due to the wide-spread practice when users just enter
a short password by the digital keyboard of their mobile phone. And no more actions. To support this we need to generate
a special login linked to the device identifier which is used later during the authentication procedure.

At the first step we generate a login:

```bash
curl -X POST -H "Authorization: Bearer $TOKEN"  -d '{"device_id" : "1234567890"}' https://testapi.copernicusgold.com/api/v1/logins
```

The result with the tokens
```javascript
{"code" : 0, "login":"M06935b2e-6639-4b49-8c8a-71452082a420"}
```

The returned login *M06935b2e-6639-4b49-8c8a-71452082a420* now can be used for authentication directly in conjunction with
the user's PIN code. Use the following request to get an access token via the obtained login:


```bash
BASIC=base64("client_id:client_secret")
curl -X POST -H "X-Device-Id: 1234567890" -H "Authorization: Basic $BASIC" -d "grant_type=password&username=M06935b2e-6639-4b49-8c8a-71452082a420&password=PIN&scope=full" https://testapi.copernicusgold.com/auth/oauth/token
```

Take a look at usage of the "x-device-id" header. Without this identifier which was used to generate the login
the authentication will fail.
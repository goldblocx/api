# General Information

Here we provide the information about the Application Programming Interface (API)
for [Goldblocx (**GBX**)](https://www.goldblocx.com) services which enables you
to create applications, register users, open accounts (wallets) in previous metals
and currencies, replenish them, trade previous metals, create corporate accounts
and use the Goldblocx platform as a **White Label** solution if you decide to develop
your own application with the use of the API.

We use the OAuth2 authentication schema that means you need an access token to work
with API queries (see the [Authentication](./docs/authentication.md) section).

# API Endpoints

Currently, we use **https://api.test.goldblocx.com/api/** as the **test** entry
point for all API queries. In the production mode the main host should be change
to 'api.goldblocx.com' instead of 'api.test.goldblocx.com'. In all examples here
we use the **$API_HOST** variable as a substitution for https://api.test.goldblocx.com
or https://api.goldblocx.com.

Some API operations connected mostly with the authorization are located on
the authorization host. In this case we use the **$AUTH_HOST** variable to denote
https://auth.test.goldblocx.com or 'https://auth.goldblocx.com' for the test and
the production authorization server respectively.

All examples of the API here were prepared with the *cUrl* utility that can be downloaded
from http://curl.haxx.se/download.html and usually is installed on most of OS platforms.
The main reason to use it is to provide a clear way how exactly our API works and
all 'curl' commands can be easily converted to any other languages.

API requests should use **https** and provide the content type as JSON (application/json) or XML (application/xml).
It depends on the "Accept" and "Content-Type" headers. The default type is JSON (if you didn't specify any
headers).

In some example you may be asked to register via the web application. Please use
the following url for **test** environment - https://web.test.goldblocx.com or
https://web.goldblocx.com for the production stage.

# API Specifications

1. [Application Registration](./docs/applications/registration.md)
2. [Authentication](./docs/authentication.md) and [Registration](./docs/registration.md)
3. [API Reference](./docs/specification.md)
4. [API Models](./docs/models/models.md)

**Goldblocx** (R) is a registered trademark of GoldPlus Assets Pte. Ltd.

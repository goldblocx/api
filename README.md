[![Build Status](https://travis-ci.org/copernicusgold/api.svg?branch=master)](https://travis-ci.org/copernicusgold/api)

# General Information

Here we provide the information about the Application Programming Interface (API)
for [Copernicus Gold](https://www.copernicusgold.com) services which enables you to create applications, to register users,
to open accounts (wallets), to replenish them, to send funds to other people, organizations and even to create own
digital assets.


We use the OAuth2 authentication scheme that means you need an access token to work
with API queries (see the [Authentication](./docs/authentication.md) section).

# API Endpoints

Currently, we use **https://testapi.copernicusgold.com/api/** as the **test** entry point for all API queries. In the
production mode the main host should be change to 'api.copernicusgold.com' instead of 'testapi.copernicusgold.com'.

All examples of the API here were prepared with *cUrl* utility that can be downloaded from: http://curl.haxx.se/download.html
and usually is installed on most of OS platforms. The main reason to use it is to provide a clear way how exactly our
REST API works and all 'curl' commands can be easily converted to any other languages. 

API requests should use **https** and provide the content type as JSON (application/json) or XML (application/xml). 
This depends on the "Accept" and "Content-Type" headers you use. The default type is JSON (if you didn't specify any
headers).

# API Specifications

1. [Application Registration](./docs/applications/registration.md)
2. [Authentication](./docs/authentication.md)
3. [API Reference](./docs/specification.md)

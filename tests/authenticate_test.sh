#!/bin/sh

source ./tests/functions

#
# Receives a one-time password: PUT /api/v1/otp
#
testOTP() {

   # Use the DEMO login to see an example of the response
   rs=`curl -s -X PUT -d '{"login":"'$USER_DEMO'"}' \
                         https://$AUTH_HOST/api/v1/otp`

   echo $rs | jq

   assertEquals 'The result is not OK' 0 $(echo $rs | jq .code)
   assertEquals 'The user is Active' '"Active"' $(echo $rs | jq .state)
}

#
# Performs the authentication and obtains a token
#
testAuthentication() {

   # Step 1. Generate a BASIC authentication header ( base64(app_id:app_secret) )
   # @see "functions" for details
   
   BASIC=$(buildBasic $APP_ID_DEMO $APP_SECRET_DEMO)

   # Step 2. Using the demo account credentials to obtain a token
   rs=`curl -s -X POST -H 'Accept: application/json' \
                       -H 'Content-Type: application/x-www-form-urlencoded' \
                       -H "Authorization: Basic $BASIC" \
                       -d "grant_type=password&username=$USER_DEMO&password=$USER_PWD_DEMO&scope=full" \
                           https://$AUTH_HOST/auth/oauth/token`

   # Will be returned something like this:
   # {  "access_token":"9660fd9f-2e3b-46dd-9828-86eadf783b5e",
   #    "token_type":"bearer",
   #    "refresh_token":"8cfe1111-6fc7-4cea-9640-03b66208ba7a",
   #    "expires_in":1209599,
   #    "scope":"full",
   #    "client_id":"testapp"  }

   echo $rs | jq

   # Extract the access token
   TOKEN=$(echo $rs | jq .access_token)

   assertNotNull $TOKEN
   assertEquals '"'$APP_ID_DEMO'"' $(echo $rs | jq .client_id)
   assertTrue "[ $(echo $rs | jq .expires_in) -gt 0 ]"
}

. shunit2-source/2.1.6/src/shunit2

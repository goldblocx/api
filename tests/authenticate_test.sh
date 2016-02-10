#!/bin/sh

source ./tests/functions

#
# Retrieving OTP:  /api/v1/otp
#
testOTP() {

   # Using the DEMO login to see an example of response
   rs=`curl -s -X PUT -d '{"login":"79999999999"}'  https://testapi.copernicusgold.com/api/v1/otp`

   assertEquals 'The result is not OK' 0 $(echo $rs | jq .code)
   assertEquals 'The user is Active' '"Active"' $(echo $rs | jq .state)
}

#
# Performs the authentication and obtaining a token
#
testAuthentication() {

   # Application credentials. In this case - a sample application
   APP_ID='testapp'
   APP_SECRET='secret'

   # Step 1. Generating the BASIC authentication header ( base64(app_id:app_secret) )
   unamestr=`uname`

   if [[ "$unamestr" == 'Linux' ]]; then
      BASIC=`echo -n "$APP_ID:$APP_SECRET" | base64`
   else 
      BASIC=`echo "$APP_ID:$APP_SECRET\c" | base64`
   fi

   # Step 2. Using the demo account credentials to obtain a token
   rs=`curl -s -X POST -H 'Accept: application/json' -H 'Content-Type: application/x-www-form-urlencoded' -H "Authorization: Basic $BASIC" -d "grant_type=password&username=79999999999&password=1234&scope=full" https://testapi.copernicusgold.com/auth/oauth/token`

   # Returned something like:

   # {  "access_token":"9660fd9f-2e3b-46dd-9828-86eadf783b5e",
   #    "token_type":"bearer",
   #    "refresh_token":"8cfe1111-6fc7-4cea-9640-03b66208ba7a",
   #    "expires_in":1209599,
   #    "scope":"full",
   #    "client_id":"testapp"  }

   echo $rs | jq

   TOKEN=$(echo $rs | jq .access_token)

   assertNotNull $TOKEN
   assertEquals '"testapp"' $(echo $rs | jq .client_id)
   assertTrue "[ $(echo $rs | jq .expires_in) -gt 0 ]"
}

. shunit2-source/2.1.6/src/shunit2

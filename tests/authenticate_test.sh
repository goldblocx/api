#!/bin/sh

. ./tests/functions

# /api/v1/otp  endpoint tests
testOTP() {
  
   # Using the DEMO login to see an example of responsOOBDe
   rs=`curl -s -X PUT -d '{"login":"79999999999"}'  https://testapi.copernicusgold.com/api/v1/otp`

   echo "Pretty output: "
   pretty $rs

   assertEquals 'The result is not OK' 0 $(echo $rs | jsn code)
   assertEquals 'The user is Active' '"Active"' $(echo $rs | jsn state)

   jq --version
   
   echo $rs | jq
}

# Performs the authentication for the demo user
testAuthentication() {
  
   APP_ID=testapp
   APP_SECRET=secret

   # Step 1. Generating the BASIC authentication header
   BASIC=`echo "$APP_ID:$APP_SECRET" | base64`
   assertNotNull $BASIC
   
   # Using the password for the demo user
   rs=`curl -s -X POST -H "Accept: application/json" -H "Authorization: Basic $BASIC" -d "grant_type=password&username=79999999999&password=1234&scope=full" https://testapi.copernicusgold.com/auth/oauth/token`
   echo "Pretty output:" $rs
}

. shunit2-source/2.1.6/src/shunit2

#!/bin/sh

source ./tests/functions

#
# Creates an application:  POST /api/v1/applications
#
testCreateApplication() {

   # Obtain a DEMO token
   getTestToken

   # Switch to a corporate entity
   switchToCorporate

   # Create an application
   MODEL='{}'
   rs=`curl -s -X POST -H "Accept: application/json" \
                       -H "Content-Type: application/json" \
                       -H "Authorization: Bearer $TOKEN" \
                       -d "$MODEL" \
                           https://$API_HOST/api/v1/applications`

   echo "Created a new app: "
   echo $rs | jq

   APP_ID=$(echo $rs | jq .app_id | trim)
   APP_SECRET=$(echo $rs | jq .app_secret | trim)

   assertNotNull $APP_ID
   assertNotNull $APP_SECRET

   assertEquals '"authorization_code"' $(echo $rs | jq '[.grant_types[]] | sort | .[0]')
   assertEquals '"password"' $(echo $rs | jq '[.grant_types[]] | sort | .[1]')   
   assertEquals '"refresh_token"' $(echo $rs | jq '[.grant_types[]] | sort | .[2]')

   # Now try to authenticate in the created application
   BASIC=$(buildBasic $APP_ID $APP_SECRET)

   rs=`curl -s -X POST -H 'Accept: application/json' \
                       -H 'Content-Type: application/x-www-form-urlencoded' \
                       -H "Authorization: Basic $BASIC" \
                       -d "grant_type=password&username=$USER_DEMO&password=$USER_PWD_DEMO&scope=full" \
                           https://$AUTH_HOST/auth/oauth/token`

   local TKN=$(echo $rs | jq .access_token | trim)

   # Check the details of the authenticated user
   rs=`curl -s -X GET -H "Accept: application/json" \
                      -H "Content-Type: application/json" \
                      -H "Authorization: Bearer $TKN" \
                          https://$API_HOST/api/v1/users`
   
   # There must be the demo user
   assertEquals 0 $(echo $rs | jq .code)
   assertEquals '"demo"' $(echo $rs | jq .name)

   # Remove the application
   rs=`curl -s -X DELETE -H 'Accept: application/json' \
                         -H 'Content-Type: application/json' \
                         -H "Authorization: Bearer $TOKEN" \
                             https://$API_HOST/api/v1/applications/$APP_ID`
   
   echo "Removing: $APP_ID"
   echo $rs | jq
}

#
# Updates Application:  PUT /api/v1/applications
#
testUpdateApplication() {

   # Obtaining a DEMO token
   getTestToken

   # Switching to a corporate entity
   switchToCorporate

   # Create an application
   MODEL='{}'
   rs=`curl -s -X POST -H "Accept: application/json" \
                       -H "Content-Type: application/json" \
                       -H "Authorization: Bearer $TOKEN" \
                       -d  "$MODEL" \
                           https://$API_HOST/api/v1/applications`
   echo "Created a new Application:"
   echo $rs | jq

   APP_ID=$(echo $rs | jq .app_id | trim)
   APP_SECRET="password"

   # Change the password (secret) and the redirects parameter
   MODEL='{"redirects":["http://localhost/login"], "app_secret":"'$APP_SECRET'", "app_id" : "'$APP_ID'"}'
   rs=`curl -s -X PUT -H "Accept: application/json" \
                      -H "Content-Type: application/json" \
                      -H "Authorization: Bearer $TOKEN" \
                      -d  "$MODEL" \
                          https://$API_HOST/api/v1/applications`
   
   echo "Updated Application:"
   echo $rs | jq
   
   # Retrieve it to see the values have changed
   rs=`curl -s -X GET -H "Accept: application/json" \
                      -H "Content-Type: application/json" \
                      -H "Authorization: Bearer $TOKEN" \
                          https://$API_HOST/api/v1/applications/$APP_ID`

   # Check the amendments 
   assertEquals '"http://localhost/login"' $(echo $rs | jq '[.redirects[]] | .[0]')
   
   # Now, try to sign in using the changed password   
   BASIC=$(buildBasic $APP_ID $APP_SECRET)

   rs=`curl -s -X POST -H 'Accept: application/json' \
                       -H 'Content-Type: application/x-www-form-urlencoded' \
                       -H "Authorization: Basic $BASIC" \
                       -d "grant_type=password&username=$USER_DEMO&password=$USER_PWD_DEMO&scope=full" \
                           https://$AUTH_HOST/auth/oauth/token`

   local TKN=$(echo $rs | jq .access_token | trim)

   # As earlier, check we have successfully signed in
   rs=`curl -s -X GET -H "Accept: application/json" \
                      -H "Content-Type: application/json" \
                      -H "Authorization: Bearer $TKN" \
                          https://$API_HOST/api/v1/users`
   
   # Checking the logging has been successful
   assertEquals 0 $(echo $rs | jq .code)
   assertEquals '"demo"' $(echo $rs | jq .name)
   
   # Removing the application
   rs=`curl -s -X DELETE -H 'Accept: application/json' \
                         -H 'Content-Type: application/json' \
                         -H "Authorization: Bearer $TOKEN" \
                             https://$API_HOST/api/v1/applications/$APP_ID`
   echo "Removing: $APP_ID"  
}

. shunit2-source/2.1.6/src/shunit2

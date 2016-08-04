#!/bin/sh

source ./tests/functions

#
# Querying: /api/v1/assets
#
testCreatingAssets() {

   # Obtaining a DEMO token
   getTestToken

   # Switching to a corporate entity
   switchToCorporate

   # Creating an application
   newApplication
   
   # Creation of a new asset
   MODEL='{"asset_code":"OIL", "description":"Oil Brent"}'
   rs=`curl -s -X POST -H "Accept: application/json" -H "Content-Type: application/json" \
                       -H "Authorization: Bearer $TOKEN" \
                          https://$API_HOST/api/v1/assets  -d "$MODEL"`

   echo "A created asset:"
   echo $rs | jq

   assertEquals '"New"' $(echo $rs | jq .state)

   # Trying to activate
   ASSET_ID=$(echo $rs | jq .asset_id | trim)
   
   assertNotNull $ASSET_ID

   MODEL='{}'
   # For non-demo users this procedure is performed with USSD confirmation
   rs=`curl -s -X PUT -H "Accept: application/json" -H "Content-Type: application/json" \
                      -H "Authorization: Bearer $TOKEN" \
                         https://$API_HOST/api/v1/assets/$ASSET_ID/activate  -d "$MODEL"`

   echo $rs | jq
   assertEquals '"Active"' $(echo $rs | jq .state)

   # Changing the capacity of the asset's network (the number of nodes in its blockchain storage)
   CAPACITY=2
   rs=`curl -s -X PUT -H "Accept: application/json" -H "Content-Type: application/json" \
                      -H "Authorization: Bearer $TOKEN" \
                         https://$API_HOST/api/v1/assets/$ASSET_ID/capacity/$CAPACITY  -d "$MODEL"`

   echo $rs | jq
   assertEquals '"Active"' $(echo $rs | jq .state)
   #assertEquals '2' $(echo $rs | jq .capacity)
   
   removeApplication $APP_ID
}

. shunit2-source/2.1.6/src/shunit2
å
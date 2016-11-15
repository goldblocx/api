#!/bin/sh

#
# Creates and activates a new asset: POST /api/v1/assets
#
testAssetLifecycle() {

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

   echo "Created a new asset:"
   echo $rs | jq

   assertEquals '"New"' $(echo $rs | jq .state)

   # Try to activate
   ASSET_ID=$(echo $rs | jq .asset_id | trim)
   
   assertNotNull $ASSET_ID

   MODEL='{}'
   # For non-demo users this procedure is finished by USSD confirmation
   rs=`curl -s -X PUT -H "Accept: application/json" -H "Content-Type: application/json" \
                      -H "Authorization: Bearer $TOKEN" \
                         https://$API_HOST/api/v1/assets/$ASSET_ID/activate  -d "$MODEL"`

   echo "Asset $ASSET_ID has been updated:"
   echo $rs | jq
   # For non-demo accounts, the state will be 'Pending' until a new blockchain database is created for
   # the given asset. In case of demo users, no blockchain is created. 
   assertEquals '"Active"' $(echo $rs | jq .state)

   # Change the capacity of the asset's network (the number of nodes in its blockchain database)
   # Initially, all new assets have 2 nodes only.
   CAPACITY=2
   rs=`curl -s -X PUT -H "Accept: application/json" -H "Content-Type: application/json" \
                      -H "Authorization: Bearer $TOKEN" \
                         https://$API_HOST/api/v1/assets/$ASSET_ID/capacity/$CAPACITY  -d "$MODEL"`

   echo "Capacity of $ASSET_ID changed to 2:"
   assertEquals '"Active"' $(echo $rs | jq .state)
   assertEquals '2' $(echo $rs | jq .capacity)
   
   # Change the capacity to be 0 (i.e. drop all nodes)
   CAPACITY=0
   rs=`curl -s -X PUT -H "Accept: application/json" -H "Content-Type: application/json" \
                      -H "Authorization: Bearer $TOKEN" \
                         https://$API_HOST/api/v1/assets/$ASSET_ID/capacity/$CAPACITY  -d "$MODEL"`

   echo "Capacity of $ASSET_ID changed to 0:"
   assertEquals '0' $(echo $rs | jq .capacity)
      
   # Remove the asset
   rs=`curl -s -X DELETE -H "Accept: application/json" -H "Content-Type: application/json" \
                         -H "Authorization: Bearer $TOKEN" \
                            https://$API_HOST/api/v1/assets/$ASSET_ID`

   echo "Asset $ASSET_ID removed"
   assertEquals '"Inactive"' $(echo $rs | jq .state)
   
   removeApplication $APP_ID
}

. shunit2-source/2.1.6/src/shunit2

#!/bin/sh

source ./tests/functions

#
# Querying:  /api/v1/assets
#
testGetAllAssets() {

   # Obtaining a DEMO token
   getTestToken

   # Switching to a corporate entity
   switchToCorporate

   # Querying available assets
   rs=`curl -s -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/assets`
   
   echo "Found assets:"
   echo $rs | jq

   # Querying available currencies (including public ones)
   rs=`curl -s -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/currencies`
   
   echo "Found currencies:"
   echo $rs | jq
}

. shunit2-source/2.1.6/src/shunit2
å
# Accounts

Returns a list of accounts with their balances, types and other information.

### REQUEST:

       GET     /api/v1/accounts

### ARGUMENTS:
       none

### EXAMPLES:

```bash
TOKEN="your access token here"
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/accounts
```


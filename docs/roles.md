# User Roles and Permissions

Returns the current user's roles which can be used to restrict access in your interface according to user's permissions.
For example, if the user has not yet entered the password.

### REQUEST:
    GET /api/v1/users/roles
### ARGUMENTS:
       none
### EXAMPLE

```bash
TOKEN="your access token is here"
curl -X GET -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/users/roles
```


### RESPONSE:
1. ["ROLE\_USER"] - for a fully authenticated user
2. ["ROLE\_EXPECT\_PASSWORD"] - in the case when the system is still expecting entering the password via the USSD menu.
3. ["ROLE\_SET\_PASSWORD"] - when the system is expecting to set a new password during the registration procedure

# User Roles

Returns the current user's roles which can be used to restrict access in your
interface according to user's permissions. For example, if the user has not yet
entered the PIN-code.

### REQUEST:

```
    GET /api/v1/users/roles
```

### ARGUMENTS:

       none

### EXAMPLE

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" $API_HOST/api/v1/users/roles
```

### RESPONSE:

* ["ROLE_USER"] - for a fully authenticated user
* ["ROLE_EXPECT_PASSWORD"] - in the case when the system is still expecting entering
  the PIN-code.
* ["ROLE_SET_PASSWORD"] - when the system is expecting to set a new PIN during
  the registration procedure

Also, there can be some specific and multiple roles,
e.g. ["ROLE_USER", "ROLE_GROUP_STAFF_CHAT"].

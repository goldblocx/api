# Cards

Returns a list of cards with their information.

### REQUEST:

       GET     /api/v1/cards

### ARGUMENTS:
       none

### EXAMPLES:

```bash
TOKEN="your access token here"
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer $TOKEN" https://testapi.copernicusgold.com/api/v1/cards
```

### RESPONSE:
```javascript
[
    {
        "id":15200,
        "state":"Active",
        "created":"2016-02-16T07:55:46.592+0000",
        "modified":"2016-02-16T07:55:47.794+0000",
        "card_bin":"411111",
        "last_four_digits":"1111",
        "valid_thru":"06/2016",
        "cardholder_name":"Alexey"
    },
    {
        "id":15201,
        "state":"Active",
        "created":"2016-02-16T07:56:46.592+0000",
        "modified":"2016-02-16T07:59:47.794+0000",
        "card_bin":"411111",
        "last_four_digits":"4444",
        "valid_thru":"08/2018",
        "cardholder_name":"Alexey"
    }
]
```

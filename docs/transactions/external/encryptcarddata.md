# Encrypt card data on client

Most modern card acquires supports client-side encryption of the sensitive card
data, for example, Stripe or Adyen.

We have a special API endpoint that returns a public key of the current card provider
to be used in this client-side encryption.

```
    GET /api/v1/cards/encrypt/info
```

The resulted model will be something like this:

```json
{
  "code": 0 ,
  "key": "pk_test_9Jjk4tL8TqleUupVpm2983ap00sJy8F0s2" ,
  "time": "2021-10-11T14:42:16Z" ,
  "card_aggregator": "Stripe"
}
```

- **key** - the public key for using in encryption.
- **time** - the current server time.
- **card_aggregator** - the name of the current used card aggregator/acquirer.

An example:

```bash
curl -X GET -H "Authorization: Bearer $TOKEN" \
            $API_HOST/api/v1/cards/encrypt/info
```

Please refer to the Stripe documentation to check how to use this encryption. 

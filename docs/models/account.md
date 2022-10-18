# Account Model

The account (or, probably, in some cases the wallet) is a basic unit for storing funds of a customer. Each account has
its own private key and all transactions which are conducted with use of this account are signed by the
key. The customer who owns the account is the only person who can get access to the key due to our robust
encryption system.

```json
{
  "balance": 2.15516 ,
  "currency": {
    "asset_id": "XAU" ,
    "description": "Gold"
  } ,
  "description": "Golden" ,
  "estimated": 2.15516 ,
  "id": 7654321 ,
  "state": "Active" ,
  "type": "Common"
}
```

### balance

The real balance of the account which shows the remainder of funds. This amount is strictly calculated based
on the credit outputs belonging to the account from the underlying ledger.

### currency

The asset (currency) which describes the nature of the account (US Dollar, gold or bitcoins).
Please refer to [assets page](./asset.md) to get more details on it.

### description

The title of accounts given by the customer. It can be 'My precious' or 'GOLD' or any other which the user
specified.

### estimated

The balance of the account which is calculated before receiving confirmations on all
transactions from the underlying ledger. If all transactions with the use of the account are
confirmed by the general ledger, the estimated and the balance fields are equals.

### type

There are several types of the account: Common, Deposit, Loan, Escrow. The 'Common' account is an account
which has general purpose. The 'Deposit' account has a restriction - you can withdraw funds from it
to other your accounts only. It means you can't send money from this account directly to another user.
Loan and Escrow can be set if the provider supports the corresponding products.

All functions available for account you can find [here](../products/accounts.md).

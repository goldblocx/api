# External transactions

All transactions connected with sending or receiving money to/from bank cards or
to bank accounts in other banks should use the 'transaction_type' field value
to be 'External'. The "direction" of a transaction (0 - "out", 1 - "in") means
whether we send or receive funds.

An additional attribute "external_channel" is used to specify a concrete kind of
the external transaction: for sending or receiving money to/from a bank card
this attribute should have the "Card" value, in the case of sending money to
a bank account the "BankAccount" value should be used.

Each type of external transactions has its own set of additional attributes and rules
which is discussed below.

Each transaction also has the "related_currency" field which mostly depends on
a concrete way of receiving or sending money. For example, to receive funds
we use "USD" or "EUR" currencies and these currencies will be presented in
a bank's card statement as the transaction currencies.

See how to retrieve necessary currencies below:

1. [Receiving funds from bank cards](./externaltransactionfromcard.md)
2. [Encrypting card data](./encryptcarddata.md)
3. [Sending funds to bank cards](./externaltransactiontocard.md)
4. [Sending funds to other banks](./externaltransactiontoaccount.md)
5. [Retrieving a list of available currencies](./currenciesfortransaction.md)

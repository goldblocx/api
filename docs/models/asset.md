# Asset (Currency) Model

One of the most exciting feature of the platform is its ability to issue own electronic
assets. They can be linked to some real value like gold, silver, other precious metals,
also, US dollar, Euro in a bank. At the same time you can issue you own asset and manage it.
All functions from our high-level API will be automatically available for any kind of assets.

All assets are linked to a current [provider](./provider.md). The platform global assets are
available for all [applications](./application.md) but custom assets are always restricted
to certain applications.

Below are provided some examples of assets.

A commodity asset: gold.

```json
{
  "asset_code": "XAU" ,
  "asset_id": "XAU" ,
  "description": "Gold" ,
  "kind": "Commodity" ,
  "scale": 5 ,
  "state": "Active" ,
  "symbol": "g" ,
  "position": 1
}
```

An asset based on a fiat currency

```json
{
  "asset_code": "USD" ,
  "asset_id": "USD" ,
  "description": "US Dollar" ,
  "kind": "Currency" ,
  "scale": 2 ,
  "state": "Active" ,
  "symbol": "$" ,
  "position": 0
}
```

Another currency-like asset:

```json
{
  "asset_code": "BTC" ,
  "asset_id": "BTC" ,
  "description": "Bitcoin" ,
  "kind": "Currency" ,
  "scale": 8 ,
  "state": "Active" ,
  "symbol": "₿" ,
  "position": 0
}
```

Or a custom asset - token, for example,

```json
{
  "asset_code": "COIN" ,
  "asset_id": "3aadb70fa8c14cddacf2ef6154709b3d" ,
  "description": "Loyalty Coins" ,
  "kind": "Token" ,
  "scale": 0 ,
  "state": "Active" ,
  "symbol": "XXX" ,
  "position": 1 ,
  "volume": 10000
}
```

### asset_id

The unique identifier of the asset. There are some predefined values for own
platform's assets, or it is generated randomly for custom assets (for example,
'3aadb70fa8c14cddacf2ef6154709b3d').

### asset_code

The human-readable value for the asset which appears in applications, messages and
transactions. The issuer of the asset can specify any value here.

### description

An internal description of the asset for understanding its purpose.

### kind

Defines the kind of the asset. It can have the following values:

* **Commodity** - if the asset is a commodity like gold, silver, oil or other precious metals.
* **Currency** - if the asset is a currency both fiat or cryptocurrency.
* **Token** - if the asset represents a custom token.

### scale

The number of digits after the comma (fraction digits). For example, if the scale is
equals to 2, the possible values look like 1233.30, 0.24 or 0.01. If the scale is zero,
then we can operate with integer values only. The latter is useful for the case when
we create loyalty points that may not have fraction parts.

### symbol

A special symbol that can be used when displaying the asset value. For example,
for US Dollar we can use "$".

### position

This value instructs display functions to put the 'symbol' before the value (
position = 0) or after the value (position = 1). For example, for US Dollar we
use position = 0 and display 2 USD as "$2". But for gold with the position = 1
we display it like "2g" or "2oz".

### volume

The volume of tokens that are in the circulation. For example, you can issue just
only 1,000 premium discount tokens to limit its total volume. 

# Encrypt card data on client

Library 'adyen.encrypt.nodom.min.js' used to encrypt card data:
- see https://github.com/Adyen/CSE-JS#javascript-only-integration
- get https://github.com/Adyen/CSE-JS/blob/master/js/adyen.encrypt.nodom.js

### EXAMPLE:
``` javascript

<script type="text/javascript" src="js/adyen.encrypt.nodom.min.js"></script>
<script type="text/javascript">
            var key = "..."; 
            var options = {"enableValidations" : false};  // See adyen.encrypt.nodom.html for details
            var cseInstance = adyen.encrypt.createEncryption(key, options);
            
            //for new card
            var cardData = {
                    number : "...",
                    cvc : "...",
                    holderName "...": ,
                    expiryMonth "...": ,
                    expiryYear "...": ,
                    generationtime : "..."
                };
            }
            var ayden_card_encrypt_data = cseInstance.encrypt(cardData);
</script>
```
The expected format for the "expiryMonth" field is "MM".
The expected format for the "expiryYear" field is "YYYY".
For fields **key** and **generationtime**, use [info for encrypt card data](./infoforencryptcard.md)

Use **ayden_card_encrypt_data** for card object in [receiving money from a bank card](./externaltransactionfromcard.md).


For existing card only **cvc** and **generationtime** required:
``` javascript
            var cardData = {
                    cvc : ...,
                    generationtime : "..."
                };
```

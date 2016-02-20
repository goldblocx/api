# Encrypt card data on client

Library ayden.js used to encrypt card data see https://github.com/Adyen/CSE-JS#javascript-only-integration

### EXAMPLE:
``` javascript
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
```
For params key and generationtime, use [info for encrypt card data](./infoforencryptcard.md)

Use ayden_card_encrypt_data for card object in [receiving money from a bank card](./externaltransactionfromcard.md).


For existing card only cvc and generationtime required:
``` javascript
                        var cardData = {
                                cvc : ...,
                                generationtime : "..."
                            };
```

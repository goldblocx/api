# Message Model

Messages are objects used for transferring text and files between the customer and
the support service of the provider.

Each message has the following structure:

```json
{
  "message": "I'm just writing you ..." ,
  "id": 12345 ,
  "attachments": [
    {
      "id": 1234567 ,
      "state": "Active" ,
      "created": "2021-10-05T17:47:45.661+0000" ,
      "modified": "2021-10-05T17:48:00.086+0000" ,
      "mime_type": "image/png" ,
      "original_file_name": "Screen Shot 2021-10-03 at 13.11.12.png" ,
      "size": 795597
    }
  ] ,
  "date": "2021-10-18T08:51:19.578+0000" ,
  "direction": "OUT" ,
  "author": {
    "id": 123456 ,
    "name": "Romanchuk Alexey" ,
    ...
  } ,
  "customer": {
    "id": 123456 ,
    "name": "Romanchuk Alexey" ,
    ...
  }
}
``` 

The fields are:

### message

The text of the message.

### direction

It can have two values: OUT (for outward messages) and IN (for incoming messages)
from the point of the current customer.

### date

It is the time stamp when the message was posted.

### attachments

An array of [file models](./file.md) that are linked (attached) to the given message.

### author

An individual customer who created the message.

### customer

A customer who owns the message. It may differ from the author when an individual
person write on behalf of a corporate entity. In this case the customer of the message
is the corporate entity.

When requested, the messages are combined to lists which have the structure like this:

```json
{
  "messages": [
    ...
  ] ,
  "total_messages": 100
}
```

Where the [...] means an array of message models.

### total_messages

The total number of the messages.

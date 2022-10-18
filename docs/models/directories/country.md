# Country model

A very simple directory with information on countries.

```json
{
  "description": "Zimbabwe" ,
  "value": "ZW" ,
  "not_operated": true
}
```

### value

The ISO 3166-1 alpha-2 code of the country, for example, SG, US, IN.

### description

The name of the country. This name is translated according to the current locale.

### not_operated

The value is true, if the current platform installation does not operate for customers from the given country.

The following endpoint is used for obtaining countries:

```bash
curl -x GET -H "Authorization: Bearer $TOKEN"  $API_HOST/api/v1/countries
```

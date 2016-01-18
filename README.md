GCloudStorage
=============

1. [Download](https://console.cloud.google.com/apis/credentials) p12 key and json in `priv/google` as `storage.p12` and `storage.json` respectively
 - `openssl pkcs12 -in storage.p12 -out storage.crt.pem -clcerts -nokeys`
 - `openssl pkcs12 -in storage.p12 -out storage.key.pem -nocerts -nodes`

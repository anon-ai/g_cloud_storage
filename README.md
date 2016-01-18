GCloudStorage
=============

1. Download p12 key and json in `priv/google` as `storage.p12` and `storage.json` respectively
 - `openssl pkcs12 -in storage.p12 -out storage.crt.pem -clcerts -nokeys`
 - `openssl pkcs12 -in storage.p12 -out storage.key.pem -nocerts -nodes`

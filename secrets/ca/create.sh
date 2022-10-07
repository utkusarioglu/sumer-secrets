#!/bin/bash

mkdir -p certs private csr
touch index.txt
echo 01 > serial

openssl ecparam -out private/intermediate.key -name prime256v1 -genkey
openssl ecparam -in private/intermediate.key -text -noout
openssl req \
  -new \
  -key intermediate.key \
  -out csr/intermediate.csr \
  -sha256 \
  -config intermediate.cnf \
  -extensions v3_ca
openssl ca \
  -keyfile ../root/private/root.key \
  -cert ../root/certs/root.crt \
  -in csr/intermediate.csr \
  -out certs/intermediate.crt \
  -config ../root/root.cnf \
  -extfile intermediate.cnf \
  -extensions v3_ca
openssl verify -CAfile ../root/certs/root.crt intermediate.crt

# openssl genrsa \
#   -des3 \
#   -passout file:mypass.enc \
#   -out private/intermediate.cakey.pem 4096

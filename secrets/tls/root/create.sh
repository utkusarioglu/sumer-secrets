#!/bin/bash

mkdir -p certs private
touch index.txt
echo 01 > serial

openssl ecparam -out private/root.key -name prime256v1 -genkey
openssl ecparam -in private/root.key -text -noout
openssl req -new -x509 -days 3650 -config root.cnf -extensions v3_ca -key private/root.key -out certs/root.crt
sleep 2
openssl x509 -noout -text -in certs/root.crt | grep -i algorithm
openssl x509 -noout -pubkey -in certs/root.crt
openssl pkey -pubout -in private/root.key

#!/bin/bash
openssl ecparam -out client.key -name prime256v1 -genkey
openssl ecparam -in client.key -text -noout
openssl req \
  -new \
  -key client.key \
  -out client.csr \
  -sha256 \
  -config client.cnf \
  -extensions req_ext
openssl ca \
  -keyfile ../root/private/root.key \
  -cert ../root/certs/root.crt \
  -in client.csr \
  -out client.crt \
  -config ../root/root.cnf \
  -extfile client.cnf \
  -extensions req_ext

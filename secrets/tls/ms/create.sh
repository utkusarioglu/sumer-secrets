#!/bin/bash
openssl ecparam -out server.key -name prime256v1 -genkey
openssl ecparam -in server.key -text -noout
openssl req -new -key server.key -out server.csr -sha256 -config server.cnf -extensions req_ext
openssl ca \
  -keyfile ../root/private/root.key \
  -cert ../root/certs/root.crt \
  -in server.csr \
  -out server.crt \
  -config ../root/root.cnf \
  -extfile server.cnf \
  -extensions req_ext
openssl verify -CAfile ../root/certs/root.crt server.crt

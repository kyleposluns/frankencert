#!/bin/bash
cd demoCA
rm -rf *
mkdir newcerts
touch index.txt
echo "1000">serial
cd ..
echo "creating root..."
openssl req -new -x509 -keyout cakey.pem -out cacert.pem
echo "creating intermediate..."
openssl req -new -key intercertkey.pem -out intercert_req.pem
openssl ca -keyfile cakey.pem -cert cacert.pem -extensions v3_ca -in intercert_req.pem -out intercert.pem
echo "creating server..."
openssl ca -keyfile intercertkey.pem -cert intercert.pem  -in server_req.pem -out server.pem
cat server.pem  intercert.pem > chain_server.pem

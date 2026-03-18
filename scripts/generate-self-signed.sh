#!/bin/bash

mkdir -p ./nginx/ssl

openssl req -x509 \
    -newkey rsa:4096 \
    -keyout ./nginx/ssl/key.pem \
    -out ./nginx/ssl/cert.crt \
    -sha256 \
    -days 365 \
    -nodes \
    -subj "/C=RU/ST=Ulyanovsk/L=Ulyanovsk/O=Simbirsoft/OU=Simbirsoft/CN=localhost"

#!/bin/bash

print_info "Requesting self-signed certificate for $DOMAIN_NAME..."
openssl req -nodes -new -x509 \
    -keyout "$P_KEY_" \
    -out "$CERTS_" \
    -subj "/C=IT/ST=Italy/L=Florence/O=Ecole42/OU=Luiss/CN=$DOMAIN_NAME" > /dev/null 2>&1

echo "🔧 Avvio Nginx..."

exec nginx -g "daemon off;"

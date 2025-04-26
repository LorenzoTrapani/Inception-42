#!/bin/bash

for cmd in openssl nginx; do
    if ! command -v $cmd &> /dev/null; then
        log_error "Comando '$cmd' non trovato. Installalo prima di procedere."
        exit 1
    fi
done

if [[ -f "/etc/nginx/nginx.conf" ]]; then
    echo "File di configurazione di Nginx trovato: /etc/nginx/nginx.conf"
else
    echo "File di configurazione di Nginx non trovato!"
    exit 1
fi

echo "Generazione del certificato SSL per $DOMAIN_NAME..."
openssl req -nodes -new -x509 \
    -keyout "/etc/ssl/private/server.key" \
    -out "/etc/ssl/certs/server.crt" \
    -subj "/C=IT/ST=Italy/L=Florence/O=Ecole42/OU=Luiss/CN=$DOMAIN_NAME" 2>dev/null

if [[ $? -ne 0 ]]; then
    echo "Error: Failed to generate self-signed certificate!"
else
    echo "Self-signed certificate generated successfully."
fi

echo "Avvio di Nginx..."
nginx -g "daemon off;"


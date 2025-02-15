#!/bin/bash

echo "🔧 Avvio Nginx..."

# Crea la directory dei certificati se non esiste
if [ ! -f "/etc/ssl/certs/server.crt" ] || [ ! -f "/etc/ssl/private/server.key" ]; then
    echo "🔑 Generazione certificati self-signed..."
    mkdir -p /etc/ssl/certs /etc/ssl/private

    openssl req -x509 -nodes -newkey rsa:2048 \
        -keyout /etc/ssl/private/server.key \
        -out /etc/ssl/certs/server.crt \
        -days 365 \
        -subj "/C=IT/ST=Lombardia/L=Milano/O=Inception/OU=DevOps/CN=${DOMAIN_NAME}"

    chmod 644 /etc/ssl/certs/server.crt
    chmod 600 /etc/ssl/private/server.key

    echo "✅ Certificati generati con successo!"
else
    echo "🔍 Certificati già presenti, nessuna generazione necessaria."
fi

exec nginx -g "daemon off;"

#!/bin/bash

# Verifica della presenza di comandi necessari
for cmd in openssl nginx; do
    if ! command -v $cmd &> /dev/null; then
        log_error "Comando '$cmd' non trovato. Installalo prima di procedere."
        exit 1
    fi
done

# Verifica della configurazione di Nginx
CONFIG_FILE="/etc/nginx/nginx.conf"
if [[ -f "$CONFIG_FILE" ]]; then
    echo "File di configurazione di Nginx trovato: $CONFIG_FILE"
else
    echo "File di configurazione di Nginx non trovato!"
    exit 1
fi
echo "Avvio configurazione SSL e Nginx..."

# DOMAIN_NAME=${DOMAIN_NAME:-"lotrapan.42.fr"}
# CERTS_=${CERTS_:-"/etc/ssl/certs/server.crt"}
# P_KEY_=${P_KEY_:-"/etc/ssl/private/server.key"}


# Generazione del certificato SSL autofirmato
echo "Generazione del certificato SSL per $DOMAIN_NAME..."
openssl req -nodes -new -x509 \
    -keyout "$P_KEY_" \
    -out "$CERTS_" \
    -subj "/C=IT/ST=Italy/L=Florence/O=Ecole42/OU=Luiss/CN=$DOMAIN_NAME" 2>dev/null

if [[ $? -ne 0 ]]; then
    echo "Error: Failed to generate self-signed certificate!"
else
    echo "Self-signed certificate generated successfully."
fi


echo "Avvio di Nginx..."
nginx -g "daemon off;"


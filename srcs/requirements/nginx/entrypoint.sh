#!/bin/bash

# Verifica della presenza di comandi necessari
for cmd in openssl nginx; do
    if ! command -v $cmd &> /dev/null; then
        log_error "Comando '$cmd' non trovato. Installalo prima di procedere."
        exit 1
    fi
done

echo "Avvio configurazione SSL e Nginx..."

DOMAIN_NAME=${DOMAIN_NAME:-"lotrapan.42.fr"}
P_KEY_=${P_KEY_:-"/etc/ssl/private/server.key"}
CERTS_=${CERTS_:-"/etc/ssl/certs/server.crt"}
CERTS_VOLUME=${CERTS_VOLUME:-"/home/lotrapan/data/certs"}

# Creazione della directory per i certificati se non esiste
mkdir -p "$CERTS_VOLUME"

# Creazione delle directory per i certificati e chiavi se non esistono
mkdir -p /etc/ssl/private && chmod 700 /etc/ssl/private
mkdir -p /etc/ssl/certs

# Generazione del certificato SSL autofirmato
echo "Generazione del certificato SSL per $DOMAIN_NAME..."
openssl req -config /etc/ssl/openssl.cnf -nodes -new -x509 \
    -keyout "$P_KEY_" \
    -out "$CERTS_" \
    -days 365 \
    -subj "/C=IT/ST=Italy/L=Rome/O=Ecole42/OU=Luiss/CN=$DOMAIN_NAME"

if [[ $? -eq 0 ]]; then
    echo "Certificato SSL generato correttamente."
else
    echo "Errore nella generazione del certificato."
    exit 1
fi

# Verifica della configurazione di Nginx
CONFIG_FILE="/etc/nginx/nginx.conf"
if [[ -f "$CONFIG_FILE" ]]; then
    echo "File di configurazione di Nginx trovato: $CONFIG_FILE"
else
    echo "File di configurazione di Nginx non trovato!"
    exit 1
fi

# Avvio del servizio Nginx
echo "Avvio di Nginx..."
nginx -g "daemon off;"


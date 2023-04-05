#!/bin/bash

source config.sh

# Check if desec secret file exists
SECRET_FILE=${PERSISTENT_STORAGE_PATH}/letsencrypt/secrets/${DOMAIN_NAME}.ini
if test -f "$SECRET_FILE"; then
    chmod 700 ${PERSISTENT_STORAGE_PATH}/letsencrypt/secrets
    chmod 600 ${SECRET_FILE}
else
    echo "Secret file ${SECRET_FILE} not found, exiting."
    echo "Please refer to https://pypi.org/project/certbot-dns-desec/ for creating desec secret file."
    exit 1
fi

${DOCKER} run -it --rm \
    -v ${PERSISTENT_STORAGE_PATH}/letsencrypt:/etc/letsencrypt \
    nxc-cron \
    certbot --certonly \
        --authenticator dns-desec \
        --dns-desec-credentials /etc/letsencrypt/secrets/${DOMAIN_NAME}.ini \
        -d "${DOMAIN_NAME}" \
        -d "*.${DOMAIN_NAME}"


#!/bin/bash

process_nextcloud_conf() {
    envsubst '$DOMAIN_NAME,$NEXTCLOUD_HTTP_PORT,$NEXTCLOUD_HTTPS_PORT' < templates/nginx/nextcloud.conf > nginx/nextcloud.conf
}

process_collabora_conf() {
    envsubst '$DOMAIN_NAME,$OFFICE_APP_PORT' < templates/nginx/collabora.conf > nginx/collabora.conf
}

process_onlyoffice_conf() {
    envsubst '$DOMAIN_NAME,$OFFICE_APP_PORT' < templates/nginx/onlyoffice.conf > nginx/onlyoffice.conf
}

run_setup() {
    echo -ne "
Choose office installation type:
0) No Office
1) Collabora Code
2) OnlyOffice Document Server
Choose an option:  "
    read -r ans
    case $ans in
    0)
        envsubst < templates/app.yaml > app.yaml
        process_nextcloud_conf

        ${DOCKER} build -t nxc-cron -f cron/Dockerfile cron
        ${DOCKER} build -t nxc-nginx -f nginx/Dockerfile nginx
        ;;
    1)
        envsubst < templates/app.yaml.collabora   > app.yaml
        process_nextcloud_conf
        process_collabora_conf

        ${DOCKER} build -t nxc-cron -f cron/Dockerfile cron
        ${DOCKER} build -t nxc-nginx -f nginx/Dockerfile.collabora nginx
        ;;
    2)
        envsubst < templates/app.yaml.onlyoffice   > app.yaml
        process_nextcloud_conf
        process_onlyoffice_conf

        ${DOCKER} build -t nxc-cron -f cron/Dockerfile cron
        ${DOCKER} build -t nxc-nginx -f nginx/Dockerfile.onlyoffice nginx
        ;;
    *)
        echo "Invalid option, exiting."
        ;;
    esac
}

source config.sh

# Generate configurations & build custom images
mkdir -p nginx
mkdir -p ${PERSISTENT_STORAGE_PATH}

run_setup

#!/bin/bash

# Command for docker (only tested with podman)
export DOCKER=podman

# Network settings
# FQDN, must have valid SSL certificate
export DOMAIN_NAME="your.domain.name"
# The ports for nextcloud, traffics from http will be redirected to https
# Use 8080 and 8443 works with rootless containers
export NEXTCLOUD_HTTP_PORT=8080
export NEXTCLOUD_HTTPS_PORT=8443
# The port for collabora or onlyoffice, must be accessible from outer network
# To avoid conflit, don't use 80 or 443 for onlyoffice and don't use 9980 for collabora
export OFFICE_APP_PORT=8980
# Path prefix for all data
export PERSISTENT_STORAGE_PATH="/mnt/storage/nextcloud"

# Database settings
# MySQL root password
export MYSQL_ROOT_PASSWORD="some_strong_password"
# Database name
export MYSQL_DATABASE="nextcloud"
# Database user informantion
export MYSQL_USER="nextcloud"
export MYSQL_PASSWORD="another_strong_password"

# OnlyOffice secret token
export JWT_SECRET="secret_token_for_onlyoffice"

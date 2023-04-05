# Rootless Nextcloud with Office

## Features
 - Rootless (using `podman` without `sudo`)
 - HTTPS support (powered by [deSEC](https://desec.io))
 - Office support (both Collabora & OnlyOffice)
 - Automatically do nextcloud cron jobs every 5 minutes
 - Automatically renew SSL certificate
 - Easy setup

## Pre-requires

 - Three ports available for nextcloud http/https and office server, these ports needs to be visible from public network
   - http: 8080
   - https: 8443
   - office: 8980
 - Container engine: the scripts are tested with `podman` in rootless mode.
 - Register your domain name to https://desec.io to get free SSL certificates

## Usage

 #### 1. Modify environment variables in `config.sh`.
  - You must modify `DOMAIN_NAME` and `PERSISTENT_STORAGE_PATH`.
  - You should modify `MYSQL_ROOT_PASSWORD`, `MYSQL_PASSWORD` and `JWT_SECRET` (if using OnlyOffice) for better security.
  - You can optionally change port settings.
 
 #### 2. Run `setup.sh` to generate necessary files and build images.
 
 #### 3. Follow the instructions in [deSEC document](https://pypi.org/project/certbot-dns-desec/) to create deSEC secret file and get your certificate using `get_cert.sh`.
  - Put the secret file `your.domain.name.ini` to `${PERSISTENT_STORAGE_PATH}/letsencrypt/secrets`
  - Running `get_cert.sh` will create a new certificate for your domain.
 
 #### 4. Run `podman kube play app.yaml` and setup using your browser.

 #### 5. Setup office:
   - Collabora
     - Set collabora server URL to https://your.domain.name:8980
   - OnlyOffice
     - Install onlyoffice app in nextcloud
     - Set onlyoffice server URL to https://your.domain.name:8980
     - The token is the `JWT_SECRET` in your `config.sh`

 #### 6. Enjoy

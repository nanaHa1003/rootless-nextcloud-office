#!/bin/sh

USER=$(getent passwd 33 | cut -d ':' -f 1)
sudo -u $USER php --define apc.enable_cli=1 -f /var/www/html/cron.php | tee /var/log/nxc-cron.log

FROM php:fpm-alpine

RUN apk add --update-cache \
    cronie \
    python3 \
    py3-pip \
  && pip install certbot certbot-dns-desec \
  && pip cache purge \
  && rm -rf /var/cache/apk/*

COPY setup.sh /root/setup.sh
RUN /root/setup.sh && rm /root/setup.sh

COPY certbot.sh  /etc/periodic/daily/certbot
COPY nxc-cron.sh /root/nxc-cron.sh

CMD ["crond", "-f"]

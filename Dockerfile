FROM alpine:latest
MAINTAINER afalter

ENV NC_USER=username \
    NC_PASS=password \
    NC_INTERVAL=500 \
    NC_URL="" \
    NC_TRUST_CERT=false \
    NC_SILENT=false \
    NC_EXIT=false   \
    NC_HIDDEN=false

# update repositories and install nextcloud-client
RUN apk update && apk add nextcloud-client && rm -rf /etc/apk/cache

# add run script
ADD run.sh /usr/bin/run.sh

VOLUME [ "/media/nextcloud" ]

CMD /usr/bin/run.sh

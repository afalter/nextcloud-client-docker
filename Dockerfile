FROM alpine:latest
MAINTAINER afalter

ARG USER=ncsync
ARG GROUP=users
ARG UID=1026
ARG GID=100

ENV USER=$USER \
    GROUP=$GROUP \
    UID=$UID \
    GID=$GID \
    NC_USER=username \
    NC_PASS=password \
    NC_INTERVAL=500 \
    NC_URL="" \
    NC_TRUST_CERT=false \
    NC_SILENT=false \
    NC_EXIT=false   \
    NC_HIDDEN=false

# create user
RUN adduser -G $GROUP -D -u $UID $USER

# update repositories and install nextcloud-client
RUN apk update && apk add nextcloud-client && rm -rf /etc/apk/cache

# add run script
ADD run.sh /usr/bin/run.sh

VOLUME [ "/media/nextcloud" ]

CMD /usr/bin/run.sh

FROM alpine:latest
MAINTAINER afalter

ARG USER=unraid
ARG GROUP=users
ARG USER_UID=99
ARG USER_GID=100

ENV USER=$USER \
    GROUP=$GROUP \
    USER_UID=$USER_UID \
    USER_GID=$USER_GID \
    NC_USER=username \
    NC_PASS=password \
    NC_INTERVAL=500 \
    NC_URL="" \
    NC_TRUST_CERT=false \
    NC_SILENT=false \
    NC_EXIT=false   \
    NC_HIDDEN=false

# create user
RUN adduser -G $GROUP -D -u $USER_UID $USER

# update repositories and install nextcloud-client
RUN apk update && apk add nextcloud-client && rm -rf /etc/apk/cache

# add run script
ADD run.sh /usr/bin/run.sh

VOLUME [ "/media/nextcloud" ]

CMD /usr/bin/run.sh

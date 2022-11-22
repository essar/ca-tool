FROM alpine

# Install dependencies
RUN apk add bash openssl zip

RUN addgroup catool
RUN adduser -D -g "catool" -G catool -h "/ca" -H catool

# Global envvars
ENV ca_home="/ca"
ENV certs_home="/certs"
ENV ca_private="/.private"
ENV USER="root"

# Set up volumes
VOLUME [ "/ca" ]
VOLUME [ "/certs" ]
VOLUME [ "/.private" ]

# Add code
RUN mkdir -p /app
COPY .default_ca /app/.default_ca
COPY *.env /app/
COPY scripts/* /app/
RUN chmod -R a+x /app/*
RUN chgrp catool /ca /certs /.private \
    && chmod g+w /ca /certs /.private

WORKDIR /app

USER catool

# Set up the entry point
ENTRYPOINT [ "/app/entrypoint" ]

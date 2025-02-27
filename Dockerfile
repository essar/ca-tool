FROM alpine

# Install dependencies
RUN apk add bash git openssl yq zip

RUN addgroup catool
RUN adduser -D -g "catool" -G catool -h "/ca" -H catool

# Global envvars
ENV ca_home="/ca"
ENV ca_private="/.private"
ENV USER="root"

# Add code
RUN mkdir -p /app
COPY .default_ca /app/.default_ca
COPY *.env /app/
COPY scripts/* /app/
RUN chmod -R a+x /app/*

USER catool

# Set up volumes
VOLUME [ "/ca" ]
VOLUME [ "/.private" ]

WORKDIR /ca

# Set up the entry point
ENTRYPOINT [ "/app/entrypoint" ]

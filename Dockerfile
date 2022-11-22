FROM alpine

# Install dependencies
RUN apk add bash openssl zip

# Global envvars
ENV ca_home="/ca"
ENV certs_home="/certs"
ENV keys_home="/keys"
ENV ca_private="/.private"

# Set up volumes
VOLUME [ "/ca" ]
VOLUME [ "/certs" ]
VOLUME [ "/keys" ]
VOLUME [ "/.private" ]

# Add code
RUN mkdir -p /app
COPY .default_ca /app/.default_ca
COPY *.env /app
COPY scripts/* /app/
RUN chmod -R u+x /app/*

WORKDIR /app

# Set up the entry point
ENTRYPOINT [ "/app/entrypoint" ]

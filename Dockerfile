FROM alpine

# Install dependencies
RUN apk add bash openssl

# Global envvars
ENV ca_home="/ca"
ENV certs_home="/certs"
ENV ca_private="/.private"

# Set up volumes
VOLUME [ "/ca" ]
VOLUME [ "/certs" ]
VOLUME [ "/.private" ]

# Add code
RUN mkdir -p /app
COPY scripts/* /app/
RUN chmod -R u+x /app/*

# Set up the entry point
ENTRYPOINT [ "/app/entrypoint.sh" ]

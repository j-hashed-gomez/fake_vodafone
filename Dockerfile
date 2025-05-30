# Base
FROM debian:bookworm-slim

# Instala strongSwan y utilidades
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      strongswan iproute2 iputils-ping nano && \
    rm -rf /var/lib/apt/lists/*

# Copiamos los scripts y configs al mismo directorio (sbin para ambos scripts)
COPY entrypoint.sh            /usr/local/sbin/entrypoint.sh
COPY ipsec.conf               /etc/ipsec.conf
COPY ipsec.secrets            /etc/ipsec.secrets

# Permisos de ejecución
RUN chmod 755 /usr/local/sbin/entrypoint.sh

# Arrancamos strongSwan en foreground usando nuestro entrypoint
ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]

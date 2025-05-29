FROM debian:bullseye

# LABEL permite añadir metadatos a la imagen (autor, versión, descripción).
LABEL author="Rafael Briceno" 
LABEL version="1.0"
LABEL description="Imagen Prueba2"

# Variables de entorno con versiones de Nagios y plugins
ENV NAGIOS_VERSION=4.4.14 \
    NAGIOS_PLUGINS_VERSION=2.3.3

# Actualizamos e instalamos dependencias
RUN apt-get update && \
    apt-get install -y wget build-essential unzip openssl libssl-dev \
    apache2 php libapache2-mod-php php-gd libgd-dev daemon curl \
    libperl-dev libpq-dev libnet-snmp-perl gettext && \
    apt-get clean

# Creamos el usuario y grupo de Nagios
RUN useradd nagios && groupadd nagcmd && \
    usermod -a -G nagcmd nagios && usermod -a -G nagcmd www-data

# Descargamos e instalamos Nagios Core
WORKDIR /tmp
RUN cd /tmp && \
    wget https://github.com/NagiosEnterprises/nagioscore/releases/download/nagios-${NAGIOS_VERSION}/nagios-${NAGIOS_VERSION}.tar.gz && \
    tar xzf nagios-${NAGIOS_VERSION}.tar.gz && \
    cd nagios-${NAGIOS_VERSION} && \
    ./configure --with-command-group=nagcmd && \
    make all && \
    make install && \
    make install-init && \
    make install-commandmode && \
    make install-config && \
    make install-webconf

# Añadimos usuario de acceso web
RUN htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin

# Habilitamos módulos de Apache y reiniciamos
RUN a2enmod rewrite cgi

# Copiamos el script de inicio
COPY start_nagios.sh /start_nagios.sh
RUN chmod +x /start_nagios.sh

EXPOSE 80

CMD ["/start_nagios.sh"]


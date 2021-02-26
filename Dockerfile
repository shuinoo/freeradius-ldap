FROM centos:7

RUN yum install freeradius freeradius-ldap freeradius-utils -y \
    && rm -rf /var/cache/yum/*

# copy config
COPY mods-available-eap /config/mods-available-eap

COPY sites-available-default /config/sites-available-default

COPY clients.conf /config/clients.conf

COPY mods-available-ldap /config/mods-available-ldap

COPY start.sh /bin/start.sh

CMD start.sh

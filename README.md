
# quick start


```sh
docker run -it --rm --name freeradius-ldap \
        -p 1812:1812/udp -p 1813:1813/udp \
        -e RADIUS_SECRET=radiussecret \
        -e LDAP_HOST=127.0.0.1 \
        -e LDAP_ADMIN_DN='cn=admin,dc=samba,dc=com' \
        -e LDAP_BASE_DN=ou=users,dc=samba,dc=com \
        -e LDAP_PASSWD=password \
        shuinoo/freeradius-ldap
```

```sh
docker run -it --rm --name freeradius-ldap \
        -p 1812:1812/udp -p 1813:1813/udp \
        -v $(pwd)/sites-available-default:/etc/raddb/sites-available/default:ro \
        -v $(pwd)/mods-available-ldap:/etc/raddb/mods-available/ldap \
        -v $(pwd)/mods-available-eap:/etc/raddb/mods-available/eap:ro \
        -v $(pwd)/clients.conf:/etc/raddb/clients.conf:ro \
        shuinoo/freeradius-ldap

```


# TLS
    use TLS encrypted connections to the LDAP database by using the StartTLS extended operation. 
    startTLS operation is supposed to be  used with normal ldap connections instead of  using 
    ldaps (port 636) connections, you must set start_tls value is yes and special /path/to/ca_file, 
    /path/to/certificate_file, /path/to/private_key_file 

```
docker run -it --rm --name freeradius-ldap \
        -p 1812:1812/udp -p 1813:1813/udp \
        -e RADIUS_SECRET=radiussecret \
        -e RADIUS_LDAP_HOST=127.0.0.1 \
        -e RADIUS_LDAP_ADMIN_DN='cn=admin,dc=samba,dc=com' \
        -e RADIUS_LDAP_BASE_DN=ou=users,dc=samba,dc=com \
        -e RADIUS_LDAP_PASSWD=password \
        -e LDAP_TLS=yes \
        -e LDAP_CA_FILE=/path/to/ca_file \
        -e LDAP_CERTIFICATE_FILE=path/to/certificate_file \
        shuinoo/freeradius-ldap
```
    Note: require_cert: Certificate Verification requirements. Can be: 
          #    'never' (do not even bother trying)
          #    'allow' (try, but don't fail if the certificate cannot be verified)
          #    'demand' (fail if the certificate does not verify)
          #    'hard'  (similar to 'demand' but fails if TLS cannot negotiate)


# test auth
    echo "User-Name=testuser,User-Password=testpasswd" | radclient localhost:1812 auth radiussecret

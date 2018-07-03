FROM osixia/openldap:1.2.1
#FROM osixia/phpldapadmin:0.7.0
RUN rm -rf /container/service/slapd/assets/config/bootstrap/ldif/custom
RUN mkdir -p /container/service/slapd/assets/config/bootstrap/ldif/custom
COPY default-users-and-roles.ldif /container/service/slapd/assets/config/bootstrap/ldif/custom
# Overview

A default preconfigured OpenLDAP instance for managing users and authentication for all services. Based on [https://github.com/osixia/docker-openldap]https://github.com/osixia/docker-openldap).

Included with this is the [PHP admin tool](./admin).

# Getting Started

## Configuration

Settings are tracked in the [.env](../.env) file used by docker-compose. This also includes settings for LDAP replication and integrating with another 
LDAP server. See [https://github.com/osixia/docker-openldap]https://github.com/osixia/docker-openldap) for more information.

## Users

* admin - Admin user for making LDAP changes and not used for logging into DevOps applications. 
* readonly - Readonly user for sub-systems to query LDAP from DevOps applications and not used for logging into DevOps applications. Please note that
changing the default password for this account will require reconfiguration in integrated applications.
* devops-admin - Admin user with devops-admin rights used for generic authorization and authentication into the DevOps application. 
* devops-user - User with devops-user rights used for generic authorization and authentication into the DevOps application. 
* devops-system - System user with devops-admin rights used internally by DevOps applications for authentication and authorization by automated jobs. Please note that
changing the default password for this account will require reconfiguration in integrated applications.

All default passwords for accounts are stored in [.env](../.evn) and the devops-* users are created during bootstrap from [./custom/default-users-and-roles.ldif](./custom/default-users-and-roles.ldif). Additional LDIF files may be placed here and will run automatically on build. 

## GUI Management

* Open [http://openldap-admin.localhost](http://openldap-admin.localhost)
* Login with the defaults (if not changed in [.env](../.env))
    * DN: `cn=admin,dc=devops`
    * Password: `P@$$w0rd`

# Overview

A default preconfigured OpenLDAP instance for managing users and authentication for all services. Based on [https://github.com/osixia/docker-openldap]https://github.com/osixia/docker-openldap).

Included with this is the [PHP admin tool](./admin).

# Getting Started

## Configuration

See [https://github.com/osixia/docker-openldap]https://github.com/osixia/docker-openldap) for more information.

## Users

* admin - Admin user for making LDAP changes and not used for logging into DevOps applications. 
* readonly - Readonly user for sub-systems to query LDAP from DevOps applications and not used for logging into DevOps applications. Please note that
changing the default password for this account will require reconfiguration in integrated applications.
* devops-admin - Admin user with devops-admin rights used for generic authorization and authentication into the DevOps application. 
* devops-user - User with devops-user rights used for generic authorization and authentication into the DevOps application. 
* devops-system - System user with devops-admin rights used internally by DevOps applications for authentication and authorization by automated jobs. Please note that
changing the default password for this account will require reconfiguration in integrated applications.

*NOTE* There is an outstanding issue where when deploying to k8s the default password is not correctly applied for some reason. You can use the admin tool to change the current password for the users and correctly login.

All default passwords for accounts are stored in [.env](../.evn) and the devops-* users are created during bootstrap from [./custom/default-users-and-roles.ldif](./custom/default-users-and-roles.ldif). Additional LDIF files may be placed here and will run automatically on build. This is a one-time run, users are only created on initial seed.

## GUI Management

* Open [http://localhost/openldap](http://localhost/openldap)
* Login with the defaults (if not changed in [.env](../.env))
    * DN: `cn=admin,dc=devops`
    * Password: `P@$$w0rd`

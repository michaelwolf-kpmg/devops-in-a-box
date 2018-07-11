A# Overview

"DevOps in a Box" - A complete turn-key solution for accelerated DevOps enablement

* [Jenkins](./jenkins) - Solution for continuous integration and delivery
* [GitLab](./gitlab) - Solution for code repository, review and task management
* [OpenLDAP](./openldap) - Solution for single LDAP authentication for all above services
* [NGINX](./proxy) - Solution for subdomain reverse proxy for all above services

*NOTE* More services in progress including: mattermost, nexus, sonarqube, prometheus, ansible...

See each of the solution providers above for more information about the implementation and configuration

# Getting Started

This solution uses docker containers for each provider and a single compose file to stitch together
an entire environment. Make sure docker is installed then just start up the entire solution:

```
docker-compose up
```

This may take a few minutes to download and build the dependencies the first time. Once complete, each
of the services should be running as configured in [docker-compose.yml](./docker-compose.yml).

Note that there are many services and volumes that must initialize, it may take 
a bit after the initial build for all services to become available, check your console. You will get 502
errors from the proxy server until the service is ready and reachable.

If you want to speed up this process for testing and only work with a single named service, you can 
reduce the total number of loaded services and only load it and its dependencies, example:

```
docker-compose up jenkins
```

* [Jenkins](./jenkins) - [http://jenkins.localhost](http://localhost/jenkins)
* [GitLab](./gitlab) - [http://gitlab.localhost](http://localhost/gitlab)
* [OpenLDAP](./openldap) - [http://openldap-admin.localhost](http://localhost/openldap)

The [docker-compose.yml](./docker-compose.yml) file makes use of environment variables which
are defined in [.env](./.env) and is read in automatically by `docker-compose` when executed.

Users are centrally managed via [OpenLDAP](../openldap). Refer to the documentation there for authentication and authorization
into the applications using the LDAP.

# Building and Deploying

* Log in with `docker login` to an account that has access to the destination repos specified by the image names in [docker-compose.yml](./docker-compose.yml) 
* Build the images using `docker-compose build`
* Push the images using `docker-compose push`

```
docker login
docker-compose build
docker-compose push
```

Once the images have been built and pushed to the repos, you can deploy using one of the helper services in [deploy](./deploy). Make
sure that [.env](./.env) is updated for the target environment, this is used to build the default configuration files for kubernetes.

```
cd deploy
docker-compose run gcp
```
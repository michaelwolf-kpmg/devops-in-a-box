FROM java:8

ENV JENKINS_SWARM_VERSION 3.12

RUN apt-get -qq update \
   && apt-get -qq -y install \
   python-pip \
   build-essential \
   procps

RUN curl -sSL https://get.docker.com/ | sh
RUN pip install docker-compose

RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION.jar \
  && chmod 755 /usr/share/jenkins

ENTRYPOINT ["/usr/bin/java", "-jar", "/usr/share/jenkins/swarm-client.jar"]
CMD ["-master", "http://jenkins:8080", "-username", "devops-system", "-passwordEnvVariable", "DOS_LDAP_SYSTEM_PASSWORD", "-labels", "docker", "-name", "docker-agent"]
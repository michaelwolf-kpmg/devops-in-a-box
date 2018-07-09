FROM mattermost/mattermost-prod-app

ARG edition=team

USER root
RUN set -x && \
    apk add --update gettext bash && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst

COPY config.json /config/config.json.template
COPY config.sh /config/
RUN chown -R mattermost:mattermost /config
RUN chmod 755 /config/config.sh

USER mattermost

#ENV MM_CONFIG=/config/config.json
ENTRYPOINT [ "/config/config.sh" ]
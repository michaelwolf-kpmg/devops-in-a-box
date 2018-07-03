#FROM gitlab/gitlab-ce:11.0.1-ce.0
FROM gitlab/gitlab-ce:9.4.3-ce.0
COPY gitlab.rb /etc/gitlab/
HEALTHCHECK --interval=30s --timeout=3s --retries=10 CMD curl --fail http://localhost || exit 1
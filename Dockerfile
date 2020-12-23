FROM pipelinecomponents/base-entrypoint:0.2.0 as entrypoint

FROM alpine:3.12.3

RUN apk add --no-cache bash libxml2-utils

COPY --from=entrypoint /entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
ENV DEFAULTCMD xmllint

COPY app /app/

WORKDIR /code/

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF

# Labels
LABEL \
    maintainer="Robbert Müller <spam.me@grols.ch>" \
    org.label-schema.description="XML Lint in a container for gitlab-ci" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="XML Lint" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://pipeline-components.dev/" \
    org.label-schema.usage="https://gitlab.com/pipeline-components/xmllint/blob/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://gitlab.com/pipeline-components/xmllint/" \
    org.label-schema.vendor="Pipeline Components"

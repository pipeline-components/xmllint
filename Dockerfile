# ==============================================================================
# Add https://gitlab.com/pipeline-components/org/base-entrypoint
# ------------------------------------------------------------------------------
FROM pipelinecomponents/base-entrypoint:0.5.0 as entrypoint

# ==============================================================================
# Component specific
# ------------------------------------------------------------------------------
FROM alpine:3.15.0
COPY app /app/
RUN apk add --no-cache libxml2-utils=2.9.12-r0

# ==============================================================================
# Generic for all components
# ------------------------------------------------------------------------------
COPY --from=entrypoint /entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
ENV DEFAULTCMD xmllint

WORKDIR /code/

# ==============================================================================
# Container meta information
# ------------------------------------------------------------------------------
ARG BUILD_DATE
ARG BUILD_REF

LABEL \
    maintainer="Robbert Müller <dev@pipeline-components.dev>" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.description="XML Lint in a container for gitlab-ci" \
    org.label-schema.name="XML Lint" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://pipeline-components.dev/" \
    org.label-schema.usage="https://gitlab.com/pipeline-components/xmllint/blob/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://gitlab.com/pipeline-components/xmllint/" \
    org.label-schema.vendor="Pipeline Components"

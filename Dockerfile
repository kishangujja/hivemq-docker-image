# syntax=docker/dockerfile:1.7
#
# HiveMQ (k8s-4.42.0) — SOW-1 hardened wrapper image
# Source: docs/sa-artifacts/image-hardening-checklist.md §2.2
#
# This wrapper is only needed if CP-H-07 confirms that a HiveMQ extension JAR
# must be baked into the image, such as hivemq-postgres-extension.
#
# Use the vendor HiveMQ image directly and mount config.xml using ConfigMap/Helm.

FROM hivemq/hivemq4@sha256:78fee46a57f18c283d551e749437250fef2da72426e28945b0a9c96ef7829345

USER root

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Uncomment only if CP-H-07 confirms extension JAR is required.
# Expected folder:
# extensions/hivemq-postgres-extension/
#
# COPY --chown=10000:10000 extensions/hivemq-postgres-extension/ \
#      /opt/hivemq/extensions/hivemq-postgres-extension/

USER 10000

ARG BUILD_DATE="unknown"
ARG GIT_SHA="unknown"
ARG GIT_REPO_URL="https://code.medtronic.com/improving/medtronic-oee-2026"

LABEL org.opencontainers.image.title="oee-hivemq"
LABEL org.opencontainers.image.version="4.42.0-${BUILD_DATE}-${GIT_SHA}"
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.source="${GIT_REPO_URL}"
LABEL org.opencontainers.image.vendor="Medtronic OEE / Improving"
LABEL org.opencontainers.image.licenses="Proprietary"
LABEL com.medtronic.oee.component="hivemq"
LABEL com.medtronic.oee.git-commit="${GIT_SHA}"
LABEL com.medtronic.oee.sow="SOW-1"
LABEL com.medtronic.oee.base="hivemq/hivemq4:k8s-4.42.0"
LABEL com.medtronic.oee.addons="extension-jar-if-required"
LABEL com.medtronic.oee.hardening-ref="docs/sa-artifacts/image-hardening-checklist.md#22-hivemq"

# Vendor ENTRYPOINT / CMD / EXPOSE retained.
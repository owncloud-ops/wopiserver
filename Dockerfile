FROM cs3org/wopiserver:v9.4.0@sha256:a6f30c52a7088a7a39640840272d4bce451b27ab34151ac9a4d746313b1389de

LABEL maintainer="ownCloud GmbH"
LABEL org.opencontainers.image.authors="ownCloud GmbH"
LABEL org.opencontainers.image.title="Wopiserver"
LABEL org.opencontainers.image.url="https://github.com/owncloud-ops/wopiserver"
LABEL org.opencontainers.image.source="https://github.com/owncloud-ops/wopiserver"
LABEL org.opencontainers.image.documentation="https://github.com/owncloud-ops/wopiserver"

ARG GOMPLATE_VERSION
ARG CONTAINER_LIBRARY_VERSION

# renovate: datasource=github-releases depName=hairyhenderson/gomplate
ENV GOMPLATE_VERSION="${GOMPLATE_VERSION:-v3.11.3}"
# renovate: datasource=github-releases depName=owncloud-ops/container-library
ENV CONTAINER_LIBRARY_VERSION="${CONTAINER_LIBRARY_VERSION:-v0.1.0}"

ADD overlay/ /

RUN addgroup -g 1001 -S app && \
    adduser -S -D -H -u 1001 -H -s /sbin/nologin -G app -g app app && \
    apk --update add --virtual .build-deps curl tar && \
    curl -SsfL -o /usr/local/bin/gomplate "https://github.com/hairyhenderson/gomplate/releases/download/${GOMPLATE_VERSION}/gomplate_linux-amd64-slim" && \
    curl -SsfL "https://github.com/owncloud-ops/container-library/releases/download/${CONTAINER_LIBRARY_VERSION}/container-library.tar.gz" | tar xz -C / && \
    chmod 755 /usr/local/bin/gomplate && \
    mkdir -p /var/spool/wopirecovery && \
    chown -R app:app /var/wopi_local_storage && \
    chown -R app:app /etc/wopi && \
    chown -R app:app /var/spool/wopirecovery && \
    rm -rf /etc/wopi/wopisecret /etc/wopi/iopsecret && \
    apk del .build-deps && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

EXPOSE 8880

USER app

ENTRYPOINT ["/usr/bin/entrypoint"]
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD /usr/bin/healthcheck
WORKDIR /etc/wopi
CMD []

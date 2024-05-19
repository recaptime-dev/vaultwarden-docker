# syntax=docker/dockerfile:1
ARG VAULTWARDEN_RELEASE=1.30.5
FROM ghcr.io/dani-garcia/vaultwarden:${VAULTWARDEN_RELEASE}-alpine

COPY src/ /

ENV PORT 3000
EXPOSE 3000

## because vaultwarden-startup requires bash, so we install that
RUN apk add --no-cache bash coreutils dumb-init \
    # Just in case we're still calling the old stuff
    && ln -s /usr/bin/vaultwarden-startup /usr/bin/bwrs-startup

WORKDIR /
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/bin/vaultwarden-startup"]

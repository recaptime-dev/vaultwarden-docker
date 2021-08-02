##################  RUNTIME IMAGE  ###################
# Create using wellbuilt vaultwarden Docker image as the base image
# Modify vaultwarden-startup to suit in your PaaS service you are using to deploy this
FROM vaultwarden/server:alpine

COPY vaultwarden-startup /usr/bin/vaultwarden-startup

ENV PORT 3000
EXPOSE 3000

## because vaultwarden-startup requires bash, so we install that
RUN apk add bash coreutils \
    # Just in case we're still calling the old stuff
    && ln -s /usr/bin/vaultwarden-startup /usr/bin/bwrs-startup

WORKDIR /
ENTRYPOINT ["usr/bin/dumb-init", "--"]
CMD ["/usr/bin/vaultwarden-startup"]

##################  RUNTIME IMAGE  ###################
# Create from wellbuilt bitwardenrs
# Modify bwrs-startup to suit in your PaaS service
# you are using to deploy this
FROM vaultwarden/server:alpine

COPY vaultwarden-startup /usr/bin/vaultwarden-startup

ENV PORT 3000
EXPOSE 3000

## because bwrs-startup requires bash, so we install that
RUN apk add bash coreutils \
    && ln -s /usr/bin/vaultwarden-startup /usr/bin/bwrs-startup

WORKDIR /
ENTRYPOINT ["usr/bin/dumb-init", "--"]
CMD ["/usr/bin/bwrs-startup"]

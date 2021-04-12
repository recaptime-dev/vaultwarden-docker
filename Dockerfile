##################  RUNTIME IMAGE  ###################
# Create from wellbuilt bitwardenrs
# Modify bwrs-startup to suit in your PaaS service
# you are using to deploy this
FROM bitwardenrs/server:alpine

COPY bwrs-startup /usr/bin/bwrs-startup

ENV PORT 3000
EXPOSE 3000

## because bwrs-startup requires bash, so we install that
RUN apk add bash

WORKDIR /
ENTRYPOINT ["usr/bin/dumb-init", "--"]
CMD ["/usr/bin/bwrs-startup"]

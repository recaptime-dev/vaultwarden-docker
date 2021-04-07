##################  RUNTIM IMAGE  ###################
# Create from wellbuilt bitwardenrs
# Modify start.sh to suit in heroku enviroment
from bitwardenrs/server:alpine

COPY bwrs-startup /usr/bin/bwrs-startup

ENV PORT 3000
EXPOSE 3000

## because bwrs-startup requires bash, so we install that
RUN apk add bash

WORKDIR /
ENTRYPOINT ["usr/bin/dumb-init", "--"]
CMD ["/usr/bin/bwrs-startup"]

##################  RUNTIM IMAGE  ###################
# Create from wellbuilt bitwardenrs
# Modify start.sh to suit in heroku enviroment
from bitwardenrs/server:alpine

COPY bwrs-startup /usr/bin/bwrs-startup

ENV PORT 3000
EXPOSE 3000

WORKDIR /
ENTRYPOINT ["usr/bin/dumb-init", "--"]
CMD ["/usr/bin/bwrs-startup"]

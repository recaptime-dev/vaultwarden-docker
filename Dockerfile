##################  RUNTIME IMAGE  ###################
# Create using wellbuilt vaultwarden Docker image as the base image
# Modify scripts/vaultwarden-startup to suit in your PaaS service you are building
# this image from source.
FROM vaultwarden/server:alpine

COPY scripts/ /usr/local/bin/

ENV PORT=3000 TZ=UTC
EXPOSE 3000

RUN apk add --no-cache \
    # Because the entrypoint script and the backup script itself need rclone and bash,
    # we'll install them through apk
    heirloom-mailx p7zip sqlite supercronic tzdata bash coreutils rclone

WORKDIR /
ENTRYPOINT ["/usr/local/bin/image-entrypoint"]

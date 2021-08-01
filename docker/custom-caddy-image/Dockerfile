FROM caddy:2-builder-alpine AS xcaddy

WORKDIR /usr/local
RUN xcaddy build --with github.com/caddy-dns/cloudflare --with github.com/caddy-dns/duckdns

FROM alpine:3.14

ARG CADDY_BINARY_DEST_PATH=/usr/local/bin/caddy
COPY --from=xcaddy /usr/local/caddy ${CADDY_BINARY_PATH}CADDY_BINARY_PATH

RUN setcap cap_net_bind_service=+ep ${CADDY_BINARY_PATH}
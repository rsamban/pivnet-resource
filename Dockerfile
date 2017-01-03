FROM alpine:3.3
RUN apk update
RUN apk add bash wget curl jq

COPY commands/check /opt/resource/check
COPY commands/in /opt/resource/in
COPY commands/out /opt/resource/out

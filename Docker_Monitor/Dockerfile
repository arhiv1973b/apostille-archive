FROM alpine:latest
RUN apk add --no-cache curl msmtp jq bash
COPY monitor.sh /usr/local/bin/monitor.sh
RUN dos2unix /usr/local/bin/monitor.sh && chmod +x /usr/local/bin/monitor.sh
ENTRYPOINT ["/usr/local/bin/monitor.sh"]

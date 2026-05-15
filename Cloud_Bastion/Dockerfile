FROM debian:stable-slim
RUN apt-get update && apt-get install -y \
    curl git rclone jq msmtp ca-certificates bash dos2unix \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /vault
RUN mkdir -p /vault/nodes /vault/registry
COPY sync-bastion.sh /usr/local/bin/sync-bastion.sh
RUN dos2unix /usr/local/bin/sync-bastion.sh && chmod +x /usr/local/bin/sync-bastion.sh
ENV REPO_URL="https://github.com/arhiv1973b/apostille-archive.git"
ENTRYPOINT ["/usr/local/bin/sync-bastion.sh"]

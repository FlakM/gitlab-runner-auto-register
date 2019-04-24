FROM gitlab/gitlab-runner:latest

RUN apt-get update -y && \
    apt-get install -y jq curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -LJO https://github.com/FlakM/gitlab-runner-cleaner/releases/download/0.0.2/gitlab-runner-cleaner.sh && \
    chmod +x gitlab-runner-cleaner.sh

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh && \
    rm -rf /entrypoint

ENTRYPOINT ["/usr/bin/dumb-init", "/entrypoint.sh"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]

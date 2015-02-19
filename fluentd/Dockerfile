FROM google/debian:wheezy
MAINTAINER liao@oneofthem.jp
# install curl and fluentd deps
RUN apt-get update \
    && apt-get install -y curl libcurl4-openssl-dev ruby ruby-dev make libxml2-dev libxml2 libxslt1-dev \
    \
    && gem install fluentd --no-ri --no-rdoc \
    && gem install nokogiri -- --use-system-libraries --no-ri --no-rdoc \
    && fluent-gem install --no-ri --no-rdoc \
    fluent-plugin-elasticsearch \
    fluent-plugin-record-modifier \
    fluent-plugin-rewrite-tag-filter \
    fluent-plugin-record-reformer \
    fluent-plugin-s3 \
    fluent-plugin-exclude-filter \
    && mkdir /etc/fluentd/ \
    \
    && cd /usr/local/bin \
    && curl -L https://github.com/jwilder/docker-gen/releases/download/0.3.4/docker-gen-linux-amd64-0.3.4.tar.gz \
    | tar -xzv \
    && \
    echo "==> Clean up..."  && \
    apt-get remove -y --auto-remove curl libcurl4-openssl-dev ruby-dev make libxml2-dev libxml2 libxslt1-dev && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

# add startup scripts and config files
ADD ./bin    /app/bin
ADD ./config /app/config

WORKDIR /app

ENV ES_HOST localhost
ENV ES_PORT 9200
ENV LOG_ENV production
ENV DOCKER_HOST unix:///tmp/docker.sock

ENTRYPOINT [ "/bin/bash" ]
CMD [ "/app/bin/start" ]

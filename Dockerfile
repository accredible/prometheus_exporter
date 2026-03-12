ARG RUBY_VERSION=3.2

FROM ruby:${RUBY_VERSION}-slim

RUN apt update && apt install -y curl git && rm -rf /var/lib/apt/lists/*

COPY . /tmp/prometheus_exporter
WORKDIR /tmp/prometheus_exporter
RUN gem build prometheus_exporter.gemspec --force && \
    gem install --no-doc prometheus_exporter-*.gem && \
    rm -rf /tmp/prometheus_exporter
WORKDIR /

EXPOSE 9394
ENTRYPOINT ["prometheus_exporter", "-b", "ANY"]

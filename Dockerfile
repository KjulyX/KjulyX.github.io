#FROM kjuly/ruby-alpine-build-base:latest
FROM ruby:3.3.1-alpine

LABEL org.opencontainers.image.authors="dev@kjuly.com" \
      org.opencontainers.image.source=https://github.com/KjulyX/KjulyX.github.io \
      org.opencontainers.image.description="Docker image for kjuly.com."

COPY Gemfile* .

RUN apk add --no-cache build-base && \
    bundle install --no-cache && \
    rm -rf /usr/local/bundle/cache && \
    apk del --purge -r build-base

#FROM kjuly/ruby-alpine-build-base:latest
FROM ruby:3.3.1-alpine

COPY Gemfile* .

RUN apk add --no-cache build-base && \
    bundle install --no-cache && \
    rm -rf /usr/local/bundle/cache && \
    apk del --purge -r build-base

# Dockerfile development version
FROM ruby:3.0.0 AS gces-app

ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user
RUN mkdir -p /aplicacao
WORKDIR /aplicacao
RUN gem install rails -v 7.0.2.3
RUN gem install bundler

ADD aplicacao/Gemfile /aplicacao/Gemfile
ADD aplicacao/Gemfile.lock /aplicacao/Gemfile.lock

RUN bundle install
ADD aplicacao /aplicacao


# Dockerfile development version
FROM ruby:3.0.0 AS gces-app

ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
COPY aplicacao/ .
RUN rm -rf node_modules vendor
RUN gem install rails -v 7.0.2.3
RUN gem install bundler
RUN bundle install
RUN chown -R user:user /opt/app
USER $USER_ID

RUN bundle exec rails db:reset
RUN rails server -b 3.226.245.90

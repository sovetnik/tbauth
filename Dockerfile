# Dockerfiles work by receiving the below instructions:
#
# clean images
# docker rmi $(docker images -f "dangling=true" -q)

FROM ruby:2.4-slim
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs libpq-dev postgresql-client

ENV INSTALL_PATH /tbauth

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./

RUN bundle install --binstubs

COPY . .

VOLUME ["$INSTALL_PATH/public"]
# In production you will very likely reverse proxy Rails with nginx.
# This sets up a volume so that nginx can read in the assets from
# the Rails Docker image without having to copy them to the Docker host.

CMD puma -C config/puma.rb

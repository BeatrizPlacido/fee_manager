FROM ruby:3.0.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /fee_manager

COPY Gemfile /Gemfile
COPY Gemfile.lock /Gemfile.lock

RUN bundle install
RUN bundle update --bundler

COPY . /fee_manager

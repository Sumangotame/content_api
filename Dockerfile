FROM ruby:2.7.8-stretch

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /rails_content_api

WORKDIR /rails_content_api

ADD Gemfile /rails_content_api/Gemfile

ADD Gemfile.lock /rails_content_api/Gemfile.lock

RUN gem install bundler

RUN bundle install

ADD . /rails_content_api
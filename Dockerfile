# Use the official Ruby image with version 2.7.8 as the base image
FROM ruby:2.7.8

# Set up the working directory inside the container
WORKDIR /rails-api

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs

# Install Rails 6.0.6.1
RUN gem install rails -v 6.0.6.1

#install bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Expose port 3000
EXPOSE 3000

# Run rails db:create and db:migrate commands
RUN rails db:create && \
    rails db:migrate

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]

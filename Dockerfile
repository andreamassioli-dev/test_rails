FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /test-rails
COPY Gemfile /test-rails/Gemfile
COPY Gemfile.lock /test-rails/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
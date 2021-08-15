FROM ruby:2.6

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
run gem install bundler:2.1.4
RUN bundle install --without test

COPY . .

ENTRYPOINT ["./lib/home_maintenance.rb"]

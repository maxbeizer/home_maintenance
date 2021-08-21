FROM ruby:2.6

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
RUN bundle config set without 'test'

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.1.4
RUN bundle version
RUN bundle install

COPY . .

ENTRYPOINT ["/run.sh"]

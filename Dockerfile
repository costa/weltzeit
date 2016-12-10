FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /weltzeit
WORKDIR /weltzeit
ADD Gemfile /weltzeit/Gemfile
ADD Gemfile.lock /weltzeit/Gemfile.lock
RUN bundle install
ADD . /weltzeit
ENTRYPOINT ["bundle", "exec", "rails"]
EXPOSE 80

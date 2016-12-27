FROM ruby:2.3.3
# NOTE includes bundler already

# NOTE https://yarnpkg.com/en/docs/install#linux-tab
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev yarn
RUN yarn global add webpack

RUN mkdir -p /weltzeit /tmp/weltzeit/bundle /tmp/weltzeit/node_modules /tmp/weltzeit/assets
ENV BUNDLE_PATH=/tmp/weltzeit/bundle
ENV NODE_PATH=/tmp/weltzeit/node_modules
ENV RAILS_ASSETS_PATH=/tmp/weltzeit/assets
WORKDIR /weltzeit

ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install --path /tmp/weltzeit/bundle --deployment  # NOTE does not respect $BUNDLE_PATH

ADD package.json .
ADD yarn.lock .
RUN yarn install --modules-folder /tmp/weltzeit/node_modules --pure-lockfile  # NOTE does not respect $NODE_PATH

RUN mkdir webpack
# NOTE this is so beautiful :')
ADD webpack webpack
ADD webpack.config.js .
# NOTE https://github.com/webpack/webpack/issues/1193
RUN webpack 2>&1 | tee /tmp/webpack.log && ! grep -iq error /tmp/webpack.log

ADD . /weltzeit/
# TODO (must play nicely with docker-compose if possible) RUN test RAILS_ENV = production && bundle exec rake assets:precompile
ENTRYPOINT ["bundle", "exec", "rails"]
EXPOSE 80

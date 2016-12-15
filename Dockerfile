FROM ruby:2.3.3
# NOTE includes bundler already

# NOTE https://yarnpkg.com/en/docs/install#linux-tab
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev yarn
RUN yarn global add webpack

RUN mkdir /weltzeit
RUN mkdir -p /tmp/weltzeit/assets
WORKDIR /weltzeit

ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install --frozen

ADD package.json .
ADD yarn.lock .
RUN yarn install --modules-folder /tmp/weltzeit/node_modules --pure-lockfile

RUN mkdir webpack
# NOTE this is so beautiful :')
ADD webpack webpack
ADD webpack.config.js .
# TODO work around https://github.com/webpack/webpack/issues/1193
RUN NODE_PATH=/tmp/weltzeit/node_modules webpack

ADD . /weltzeit/
ENTRYPOINT ["bundle", "exec", "rails"]
EXPOSE 80

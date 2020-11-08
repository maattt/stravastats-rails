FROM ruby:2.7.1-buster

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y sudo nodejs yarn

RUN useradd -ms /bin/bash user

RUN mkdir /app
WORKDIR /app
COPY . /app

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN bundle install

USER user
CMD ["/entrypoint.sh"]
# CMD tail -f /dev/null
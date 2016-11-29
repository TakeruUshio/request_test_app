FROM groovenauts/ruby:2.1.2
MAINTAINER magellan@groovenauts.jp

ENV RAILS_ENV production

ADD . /usr/src/app
WORKDIR /usr/src/app
VOLUME /usr/src/app/log

RUN bundle install --system

CMD ["bundle", "exec", "magellan-rails"]


FROM ruby:2.7.0-alpine

RUN apk update && apk add build-base nodejs yarn postgresql-dev && apk add --update tzdata

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME
COPY Gemfile.lock $APP_HOME
COPY yarn.lock $APP_HOME

RUN bundle install
RUN yarn install --check-files

COPY . .

EXPOSE 3000

CMD ["bin/rails", "server", "-p", "3000", "-b", "0.0.0.0"]
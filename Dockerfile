FROM ruby:2.7.0-alpine

RUN apk update && apk add build-base nodejs yarn postgresql-dev && apk add --update tzdata

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock yarn.lock ./

RUN bundle install
RUN yarn install --check-files

COPY . .

CMD ["bundle", "exec", "rails", "server"]

FROM ruby:2.5.3-alpine

RUN apk update && apk add build-base nodejs yarn postgresql-dev && apk add --update tzdata

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock yarn.lock ./

RUN bundle install --binstubs
RUN yarn install

COPY . .

CMD ["rails", "server"]

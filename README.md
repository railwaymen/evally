# Evally ![version](https://img.shields.io/badge/version-0.5-blue) [![Build Status](https://travis-ci.com/railwaymen/evally.svg?branch=master)](https://travis-ci.com/railwaymen/evally) ![coverage](https://img.shields.io/badge/coverage-100%25-success)
A simple web application for managing periodic skills evaluations of employees.

[![forthebadge](http://forthebadge.com/images/badges/made-with-ruby.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/made-with-vue.svg)](http://forthebadge.com)

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Requirements](#requirements)
- [Instalation](#instalation)
- [Feedback](#feedback)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Manage your employees by tracking their skills development based on own customized questionnaires. Evally, built with Ruby on Rails and Vue.js as Single Page Application, can be your basic tool for targeting career paths of your employees and observing the human potential of your company.

## Features

A few of the things that you can do with Evally:
- prepare own customized questionnaires
- use a three stars rating, 'yes or no' option or text to evaluate employee
- manage hired and archived employees
- save evaluation drafts for further modifications
- track upcoming evaluations
- archive users activities
- share evaluations by unique and safe link
- search employees by skills
- present the analytics about employees, employment changes and evaluations on charts
- use one of two available languages: Polish, English
- as an admin delegate employee's evaluations to user with evaluator role

## Requirements

- Ruby 2.5.0+
- PostgreSQL 10.6+
- Node.js 6.14.4+
- Yarn 1.x+

## Instalation

##### 1. Pull the repository

```bash
git clone https://github.com/railwaymen/evally.git
```

##### 2. Install application dependencies

Run the following commands to install all required dependencies.

```bash
bundle install
yarn install
```


##### 3. Update seeds.rb file

Update db/seeds.rb file to provide credentials for user who will be created during database setup (look at next step).

```ruby
User.find_or_create_by!(email: 'admin@example.com') do |u|
  u.password = 'password'
  u.first_name = 'John'
  u.last_name = 'Doe'
  u.role = 'admin'
end
```

##### 4. Create and setup the database

Run the following commands to create and setup the database.

```bash
bundle exec rake db:create
bundle exec rake db:setup
```

##### 5. Start the Rails server

You can start the development rails server in the way given below:

```bash
# run rails server
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000

If you want to use live code reloading, or you have enough JavaScript that on-demand compilation is too slow, you'll need to run:

```bash
# run webpack dev server
./bin/webpack-dev-server
```

## Feedback

Feel free to send us feedback. Feature requests are always welcome. If you wish to contribute, please take a quick look at the guidelines!

If you notice any bugs in the app, see some code that can be improved, or have features you would like to be added, please create a bug report or a feature request!

A good bug report must include the following four things:

1. **The steps to reproduce the bug**: Give detailed steps on how to reproduce the problem
2. **The expected behavior of the application**: It’s important to include the result you’re expecting, as it might differ from how the program was designed to work.
3. **The observed behavior of the application**
4. **Additional info**: ... like some links, images etc.

## Contributing

We encourage you to contribute to Evally! See [CONTRIBUTING](CONTRIBUTING.md) for guidelines about how to proceed.

Thank you for your interest in contributing! Please feel free to put up a PR for any issue or feature request.

If you want to open a PR that fixes a bug or adds a feature, then we can't thank you enough! It is definitely appreciated if an issue has been created before-hand so it can be discussed first.

## License

Evally is released under the *GNU GPL* license.

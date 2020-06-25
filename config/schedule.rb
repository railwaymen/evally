# frozen_string_literal: true

set :output, 'log/cron.log'
set :environment, Rails.env

every :month, at: '6am' do
  rake 'notifications:upcoming_evaluations'
end

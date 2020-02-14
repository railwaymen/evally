# frozen_string_literal: true

FactoryBot.define do
  factory :position_change do
    previous_position   { 'Junior Manager' }
    current_position    { 'Manager' }
    changed_on          { '2019-10-05' }

    employee
  end
end

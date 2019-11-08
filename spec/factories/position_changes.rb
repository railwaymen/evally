FactoryBot.define do
  factory :position_change do
    previous_position   { 'Junior Manager' }
    current_position    { 'Manager' }
    changed_at          { '2019-10-05' }

    employee
  end
end

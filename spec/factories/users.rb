FactoryBot.define do
  factory :user do |u|
    u.sequence(:email)     { |t| "user#{t}@example.com" }
    password               { '1234qwer' }
    first_name             { 'Joe' }
    last_name              { 'Doe' }
  end
end

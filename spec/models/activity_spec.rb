# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Activity, type: :model do
  it { is_expected.to belong_to(:user) }

  it { is_expected.to belong_to(:activable) }

  it 'has correct title and description' do
    employee = FactoryBot.create(:employee)
    activity = FactoryBot.create(
      :activity,
      action: 'create',
      activable: employee,
      activable_name: employee.first_name
    )

    expect(activity.title).to eq 'New employee'
    expect(activity.description).to eq "Welcome to new employee #{employee.first_name}!"
  end
end

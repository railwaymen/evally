# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EmployeesAnalyticsQuery do
  it 'returns proper values' do
    base_date = Date.current

    # 0 days
    FactoryBot.create(
      :employee,
      state: 'hired',
      hired_on: base_date
    )

    # 400 days
    FactoryBot.create(
      :employee,
      state: 'archived',
      hired_on: base_date - 400.days,
      archived_on: base_date
    )

    # 380 days
    FactoryBot.create(
      :employee,
      state: 'hired',
      hired_on: base_date - 380.days
    )

    # 64 days
    FactoryBot.create(
      :employee,
      state: 'archived',
      hired_on: base_date - 464.days,
      archived_on: base_date - 400.days
    )

    expect(described_class.call).to include(
      'hired_employees_number' => 2,
      'archived_employees_number' => 2,
      'new_employees_number_this_year' => 1,
      'archived_employees_number_this_year' => 1,
      'average_employment_in_months' => 7.0
    )
  end
end

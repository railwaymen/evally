# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EmployeesAnalyticsQuery do
  it 'returns proper calculations' do
    base_date = Date.current

    # hired - employment 10 days
    FactoryBot.create(
      :employee,
      state: 'hired',
      hired_on: base_date - 10.days,
      archived_on: nil
    )

    # hired - employment 30 days
    FactoryBot.create(
      :employee,
      state: 'hired',
      hired_on: base_date - 30.days,
      archived_on: nil
    )

    # hired - employment 100 days
    FactoryBot.create(
      :employee,
      state: 'hired',
      hired_on: base_date - 100.days,
      archived_on: nil
    )

    # archived - employment 580 days
    FactoryBot.create(
      :employee,
      state: 'hired',
      hired_on: base_date - 580.days,
      archived_on: nil
    )

    # archived - employment 210 days
    FactoryBot.create(
      :employee,
      state: 'archived',
      hired_on: base_date - 270.days,
      archived_on: base_date - 60.days
    )

    # archived - employment 180 days
    FactoryBot.create(
      :employee,
      state: 'archived',
      hired_on: base_date - 450.days,
      archived_on: base_date - 270.days
    )

    expect(described_class.call).to be_a Hash
    # TODO: how to test returned values
  end
end

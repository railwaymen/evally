# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EmployeesPastYearChartQuery do
  it 'returns proper values' do
    base_date = Date.current

    past_month = ->(n) { (base_date - n.months).at_beginning_of_month.to_s }

    FactoryBot.create(
      :employee,
      state: 'hired',
      hired_on: base_date
    )

    FactoryBot.create_list(
      :employee,
      2,
      state: 'hired',
      hired_on: base_date - 2.months
    )

    FactoryBot.create(
      :employee,
      state: 'hired',
      hired_on: base_date - 13.months
    )

    FactoryBot.create(
      :employee,
      state: 'archived',
      hired_on: base_date - 24.months,
      archived_on: base_date - 18.months
    )

    FactoryBot.create_list(
      :employee,
      2,
      state: 'archived',
      hired_on: base_date - 24.months,
      archived_on: base_date - 6.months
    )

    expect(described_class.call).to contain_exactly(
      { 'label' => past_month.call(0), 'hired_value' => 1, 'archived_value' => 0 },
      { 'label' => past_month.call(1), 'hired_value' => 0, 'archived_value' => 0 },
      { 'label' => past_month.call(2), 'hired_value' => 2, 'archived_value' => 0 },
      { 'label' => past_month.call(3), 'hired_value' => 0, 'archived_value' => 0 },
      { 'label' => past_month.call(4), 'hired_value' => 0, 'archived_value' => 0 },
      { 'label' => past_month.call(5), 'hired_value' => 0, 'archived_value' => 0 },
      { 'label' => past_month.call(6), 'hired_value' => 0, 'archived_value' => 2 },
      { 'label' => past_month.call(7), 'hired_value' => 0, 'archived_value' => 0 },
      { 'label' => past_month.call(8), 'hired_value' => 0, 'archived_value' => 0 },
      { 'label' => past_month.call(9), 'hired_value' => 0, 'archived_value' => 0 },
      { 'label' => past_month.call(10), 'hired_value' => 0, 'archived_value' => 0 },
      { 'label' => past_month.call(11), 'hired_value' => 0, 'archived_value' => 0 }
    )
  end
end

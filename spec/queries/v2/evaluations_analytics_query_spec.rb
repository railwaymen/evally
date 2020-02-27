# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EvaluationsAnalyticsQuery do
  it 'returns proper values' do
    employee1 = FactoryBot.create(
      :employee,
      state: 'hired'
    )

    employee2 = FactoryBot.create(
      :employee,
      state: 'hired'
    )

    employee3 = FactoryBot.create(
      :employee,
      state: 'archived',
      archived_on: 13.months.ago
    )

    FactoryBot.create(
      :evaluation,
      state: 'completed',
      completed_at: Time.current,
      employee: employee1
    )

    FactoryBot.create(
      :evaluation,
      state: 'completed',
      completed_at: 14.months.ago,
      employee: employee3
    )

    expect(described_class.call).to include(
      'average_evaluations' => 0.5,
      'total_evaluations_number' => 2,
      'evaluations_number_this_year' => 1
    )
  end
end

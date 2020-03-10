# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::Evaluations::AnalyticsQuery do
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
      :evaluation_completed_employee,
      completed_at: Time.current,
      evaluable: employee1
    )

    FactoryBot.create(
      :evaluation_draft_employee,
      evaluable: employee2
    )

    FactoryBot.create(
      :evaluation_completed_employee,
      completed_at: 14.months.ago,
      evaluable: employee3
    )

    expect(described_class.call).to include(
      'average_evaluations' => 0.5,
      'total_evaluations_number' => 2,
      'evaluations_number_this_year' => 1
    )
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EvaluationsPastYearChartQuery do
  it 'returns proper values' do
    base_date = Date.current

    past_month = ->(n) { (base_date - n.months).at_beginning_of_month.to_s }

    FactoryBot.create(
      :evaluation,
      state: 'draft'
    )

    FactoryBot.create(
      :evaluation,
      state: 'completed',
      completed_at: base_date
    )

    FactoryBot.create_list(
      :evaluation,
      2,
      state: 'completed',
      completed_at: base_date - 6.months
    )

    expect(described_class.call).to contain_exactly(
      { 'label' => past_month.call(0), 'value' => 1 },
      { 'label' => past_month.call(1), 'value' => 0 },
      { 'label' => past_month.call(2), 'value' => 0 },
      { 'label' => past_month.call(3), 'value' => 0 },
      { 'label' => past_month.call(4), 'value' => 0 },
      { 'label' => past_month.call(5), 'value' => 0 },
      { 'label' => past_month.call(6), 'value' => 2 },
      { 'label' => past_month.call(7), 'value' => 0 },
      { 'label' => past_month.call(8), 'value' => 0 },
      { 'label' => past_month.call(9), 'value' => 0 },
      { 'label' => past_month.call(10), 'value' => 0 },
      { 'label' => past_month.call(11), 'value' => 0 }
    )
  end
end

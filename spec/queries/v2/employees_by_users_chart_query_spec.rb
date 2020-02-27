# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EmployeesByUsersChartQuery do
  it 'returns proper values' do
    user1, user2 = FactoryBot.create_list(:user, 2, role: 'evaluator')
    admin = FactoryBot.create(:user, role: 'admin')

    FactoryBot.create(
      :employee,
      state: 'hired',
      evaluator: user1
    )

    FactoryBot.create(
      :employee,
      state: 'hired',
      evaluator: admin
    )

    expect(described_class.call).to include(
      { 'label' => user1.fullname, 'value' => 1 },
      { 'label' => user2.fullname, 'value' => 0 },
      { 'label' => admin.fullname, 'value' => 1 }
    )
  end
end

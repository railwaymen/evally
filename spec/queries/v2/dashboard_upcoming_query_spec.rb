# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::DashboardUpcomingQuery do
  it 'return employees except these with ongoing evaluations' do
    employee1, employee2, employee3 = FactoryBot.create_list(:employee, 3)
    FactoryBot.create(:employee, state: :archived)

    FactoryBot.create(:evaluation, :draft, employee: employee2)
    FactoryBot.create(:evaluation, :completed, employee: employee3)

    result = described_class.call
    expect(result.map(&:id)).to contain_exactly(employee1.id, employee3.id)
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::Dashboard::UpcomingQuery do
  it 'return employees except these with ongoing evaluations' do
    employee1, employee2, employee3 = FactoryBot.create_list(:employee, 3)
    FactoryBot.create(:employee, state: :archived)

    FactoryBot.create(:evaluation_draft_employee, evaluable: employee2)
    FactoryBot.create(:evaluation_completed_employee, evaluable: employee3)

    result = described_class.new(Employee.all).call
    expect(result.map(&:id)).to contain_exactly(employee1.id, employee3.id)
  end
end

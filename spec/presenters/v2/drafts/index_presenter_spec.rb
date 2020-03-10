# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::Drafts::IndexPresenter do
  it 'returns draft evaluation for not archived employee' do
    employee = FactoryBot.create(:employee)

    FactoryBot.create(
      :evaluation_completed_employee,
      evaluable: employee
    )
    draft_evaluation = FactoryBot.create(
      :evaluation_draft_employee,
      evaluable: employee
    )

    archived_employee = FactoryBot.create(:employee, state: :archived)
    FactoryBot.create(
      :evaluation_completed_employee,
      evaluable: archived_employee
    )
    FactoryBot.create(
      :evaluation_draft_employee,
      evaluable: archived_employee
    )

    user = FactoryBot.create(:user)
    presenter = described_class.new(user)

    expect(presenter.drafts.length).to eq(1)
    expect(presenter.drafts.ids).to contain_exactly draft_evaluation.id
  end
end

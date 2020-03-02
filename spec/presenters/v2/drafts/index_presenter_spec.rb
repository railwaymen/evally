# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::Drafts::IndexPresenter do
  it 'returns draft evaluation for not archived employee' do
    employee = FactoryBot.create(:employee)

    FactoryBot.create(:evaluation, :completed, employee: employee)
    draft_evaluation = FactoryBot.create(:evaluation, :draft, employee: employee)

    archived_employee = FactoryBot.create(:employee, state: :archived)
    FactoryBot.create(:evaluation, :completed, employee: archived_employee)
    FactoryBot.create(:evaluation, :draft, employee: archived_employee)

    user = FactoryBot.create(:user)
    presenter = described_class.new(user)

    expect(presenter.drafts.length).to eq(1)
    expect(presenter.drafts.map(&:id)).to contain_exactly(draft_evaluation.id)
  end
end

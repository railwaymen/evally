# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  it { is_expected.to belong_to(:evaluable) }

  it do
    is_expected.to(
      define_enum_for(:state)
        .with_values(
          draft: 'draft',
          completed: 'completed',
          archived: 'archived'
        )
        .backed_by_column_of_type(:string)
    )
  end

  it { is_expected.to accept_nested_attributes_for(:sections).allow_destroy(false) }

  describe 'methods' do
    context '.employee' do
      it 'returns employee' do
        employee = FactoryBot.create(:employee)
        evaluation = FactoryBot.create(:evaluation_draft_employee, evaluable: employee)

        expect(evaluation.employee).to eq employee
      end

      it 'returns nil' do
        recruit_document = FactoryBot.create(:recruit_document)
        recruit = recruit_document.recruit

        evaluation = FactoryBot.create(:evaluation_draft_recruit, evaluable: recruit)

        expect(evaluation.employee).to eq nil
      end
    end

    context '.employee' do
      it 'returns nil' do
        employee = FactoryBot.create(:employee)
        evaluation = FactoryBot.create(:evaluation_draft_employee, evaluable: employee)

        expect(evaluation.recruit).to eq nil
      end

      it 'returns employee' do
        recruit_document = FactoryBot.create(:recruit_document)
        recruit = recruit_document.recruit

        evaluation = FactoryBot.create(:evaluation_draft_recruit, evaluable: recruit)

        expect(evaluation.recruit).to eq recruit
      end
    end
  end
end

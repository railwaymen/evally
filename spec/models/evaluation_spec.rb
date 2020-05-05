# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  it { is_expected.to belong_to(:evaluable) }

  it { is_expected.to validate_presence_of(:position) }

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
        recruit = FactoryBot.create(:recruit)
        evaluation = FactoryBot.create(:evaluation_draft_recruit, evaluable: recruit)

        expect(evaluation.employee).to eq nil
      end
    end

    context '.recruit' do
      it 'returns nil' do
        employee = FactoryBot.create(:employee)
        evaluation = FactoryBot.create(:evaluation_draft_employee, evaluable: employee)

        expect(evaluation.recruit).to eq nil
      end

      it 'returns employee' do
        recruit = FactoryBot.create(:recruit)
        evaluation = FactoryBot.create(:evaluation_draft_recruit, evaluable: recruit)

        expect(evaluation.recruit).to eq recruit
      end
    end

    context '.notifiable_path' do
      it 'returns path for draft employee evaluation' do
        evaluation = FactoryBot.create(:evaluation_draft_employee)

        expect(evaluation.notifiable_path).to eq "/app/evaluations/#{evaluation.id}"
      end

      it 'returns path for completed employee evaluation' do
        evaluation = FactoryBot.create(:evaluation_completed_employee)
        employee = evaluation.employee

        expect(evaluation.notifiable_path).to eq(
          "/app/employees/#{employee.id}/evaluations/#{evaluation.id}"
        )
      end

      it 'returns path to dashboard' do
        evaluat = FactoryBot.create(:evaluation_draft_recruit)
        recruit = evaluat.evaluable

        expect(evaluat.notifiable_path).to eq(
          "/app/recruitments/#{recruit.public_recruit_id}/documents/#{evaluat.recruit_document_id}"
        )
      end
    end
  end
end

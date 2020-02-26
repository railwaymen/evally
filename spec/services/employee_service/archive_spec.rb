# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeeService::Archive do
  describe 'call' do
    let(:admin) { create(:user, role: 'admin') }
    let(:employee) { create(:employee) }
    let(:archived_on) { '10-01-2020' }

    subject do
      EmployeeService::Archive.new(employee: employee, archived_on: archived_on,
                                   user: admin)
    end

    it 'returns true' do
      expect(subject.call).to eq true
    end

    it 'sets archived for employee' do
      subject.call

      expect(employee.reload.state).to eq('archived')
    end

    it 'sets archived_on for employee' do
      subject.call

      expect(employee.reload.archived_on).to eq(Date.parse(archived_on))
    end

    it 'sets nil for employee evaluator_id' do
      subject.call

      expect(employee.reload.evaluator_id).to eq(nil)
    end

    context 'empty archived_on' do
      let(:archived_on) { nil }

      it 'doesnt archive employee' do
        subject.call

        expect(employee.reload.state).to eq('hired')
      end

      it 'sets errors' do
        subject.call

        expect(employee.errors.messages[:archived_on]).to eq(["can't be blank"])
      end
    end

    context 'draft evaulations for employee' do
      before do
        create(:evaluation, employee: employee, state: 'draft')
      end

      it 'doesnt archive employee' do
        expect { subject.call }.to raise_error(ErrorResponderService)

        expect(employee.reload.state).to eq('hired')
      end

      it 'sets errors' do
        expect { subject.call }.to raise_error(ErrorResponderService)

        expect(employee.errors['archived_on'])
          .to eq [I18n.t('activerecord.errors.messages.has_draft_evaluations')]
      end
    end
  end
end

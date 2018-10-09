require 'rails_helper'

RSpec.describe V1::EmployeeForm do

  let(:form) { V1::EmployeeForm.new(Employee.new) }

  describe 'validation'do

    it 'expects to return true if params ok' do
      form.attributes = attributes_for(:employee)
      expect(form.valid?).to be true
    end

    it 'expects to respond with errors', :aggregate_failures do
      aggregate_failures 'when first_name blank' do
        form.attributes = attributes_for(:employee, first_name: '')
        expect(form.valid?).to be false
      end

      aggregate_failures 'when last_name blank' do
        form.attributes = attributes_for(:employee, last_name: '')
        expect(form.valid?).to be false
      end

      aggregate_failures 'when position blank' do
        form.attributes = attributes_for(:employee, position: '')
        expect(form.valid?).to be false
      end

      aggregate_failures 'when hired_at blank' do
        form.attributes = attributes_for(:employee, hired_at: '')
        expect(form.valid?).to be false
      end
    end
  end
end

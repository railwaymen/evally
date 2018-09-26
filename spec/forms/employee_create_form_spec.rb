require 'rails_helper'

RSpec.describe V1::EmployeeCreateForm do

  let(:form) { V1::EmployeeCreateForm.new(Employee.new) }
  let(:params) { attributes_for(:employee) }

  describe 'validation'do

    it 'expects to return true if params ok' do
      expect(form.validate(params)).to be true
    end

    context 'expects to respond failure when' do
      after(:each) { expect(form.validate(params)).to eq false }

      it 'first name blank' do
        params[:first_name] = ''
      end

      it 'last name blank' do
        params[:last_name] = ''
      end

      it 'position blank' do
        params[:position] = ''
      end

      it 'hired_at blank' do
        params[:hired_at] = ''
      end
    end
  end
end

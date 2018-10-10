require 'rails_helper'

RSpec.describe V1::EmployeeForm do

  let(:form) { V1::TemplateForm.new(Template.new) }

  describe 'validation'do

    it 'expects to return true if params ok' do
      form.attributes = attributes_for(:template, sections_attributes: [])
      expect(form.valid?).to be true
    end

    it 'expects to respond with errors', :aggregate_failures do
      aggregate_failures 'when name blank' do
        form.attributes = attributes_for(:template, name: '', sections_attributes: [])
        expect(form.valid?).to be false
      end

      aggregate_failures 'when state blank' do
        form.attributes = attributes_for(:template, state: '', sections_attributes: [])
        expect(form.valid?).to be false
      end
    end
  end
end

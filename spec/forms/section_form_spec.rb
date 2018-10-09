require 'rails_helper'

RSpec.describe V1::EmployeeForm do

  let(:form) { V1::SectionForm.new(Section.new) }

  describe 'validation'do

    it 'expects to return true if params ok' do
      form.attributes = attributes_for(:section)
      expect(form.valid?).to be true
    end

    it 'expects to respond with errors', :aggregate_failures do
      aggregate_failures 'when name blank' do
        form.attributes = attributes_for(:section, name: '')
        expect(form.valid?).to be false
      end

      aggregate_failures 'when group blank' do
        form.attributes = attributes_for(:section, group: '')
        expect(form.valid?).to be false
      end

      aggregate_failures 'when unknown group' do
        form.attributes = attributes_for(:section, group: 'random')
        expect(form.valid?).to be false
      end

      aggregate_failures 'when width blank' do
        form.attributes = attributes_for(:section, width: '')
        expect(form.valid?).to be false
      end

      aggregate_failures 'when unknown width' do
        form.attributes = attributes_for(:section, width: 'minimal')
        expect(form.valid?).to be false
      end

      aggregate_failures 'when position blank' do
        form.attributes = attributes_for(:section, position: nil)
        expect(form.valid?).to be false
      end

      aggregate_failures 'when position is not integer' do
        form.attributes = attributes_for(:section, position: 3.14)
        expect(form.valid?).to be false
      end

      aggregate_failures 'when skills property is not Array' do
        form.attributes = attributes_for(:section, skills: 'Lorem ipsum ...')
        expect(form.valid?).to be false
      end

      aggregate_failures 'when skill has no name' do
        form.attributes = attributes_for(:section, skills: [{ random: 'Lorem ipsum ...', value: 1 }])
        expect(form.valid?).to be false
      end

      aggregate_failures 'when skill has no value' do
        form.attributes = attributes_for(:section, skills: [{ name: 'Skill 1', random: 'Lorem ipsum ...' }])
        expect(form.valid?).to be false
      end
    end
  end
end

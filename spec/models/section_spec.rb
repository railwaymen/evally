# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Section, type: :model do
  it { is_expected.to belong_to(:sectionable) }

  it { is_expected.to define_enum_for(:group) }

  it { is_expected.to define_enum_for(:width) }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:group) }

  it { is_expected.to validate_inclusion_of(:group).in_array(Section.groups.keys) }

  it { is_expected.to validate_presence_of(:width) }

  it { is_expected.to validate_inclusion_of(:width).in_array(Section.widths.keys) }

  it { is_expected.to validate_presence_of(:position) }

  it { should validate_numericality_of(:position).only_integer }

  context 'custom validation' do
    it 'expect to be invalid', :aggregate_failures do
      aggregate_failures 'when skills is not an array' do
        attrs = attributes_for(:section, skills: 'Lorem ipsum')
        expect(Section.new(attrs)).to be_invalid
      end

      aggregate_failures 'when skilll do not have value' do
        attrs = attributes_for(:section, skills: [{ name: 'Lorem' }])
        expect(Section.new(attrs)).to be_invalid
      end

      aggregate_failures 'when skilll do not have name' do
        attrs = attributes_for(:section, skills: [{ value: 10 }])
        expect(Section.new(attrs)).to be_invalid
      end
    end
  end
end

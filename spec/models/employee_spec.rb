# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  it { is_expected.to have_db_index(:last_name) }

  it { is_expected.to belong_to(:evaluator).class_name('User').optional }

  it { is_expected.to validate_presence_of(:first_name) }

  it { is_expected.to validate_presence_of(:last_name) }

  it { is_expected.to validate_presence_of(:position) }

  it { is_expected.to validate_presence_of(:hired_on) }

  describe 'enums' do
    it 'expects correct values for state' do
      is_expected.to define_enum_for(:state).backed_by_column_of_type(:string)
    end
  end
end

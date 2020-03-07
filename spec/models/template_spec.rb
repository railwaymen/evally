# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Template, type: :model do
  it { is_expected.to have_db_index(:name) }

  it { is_expected.to belong_to(:creator).class_name('User').optional }

  it { is_expected.to accept_nested_attributes_for(:sections).allow_destroy(true) }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:destination) }

  describe 'enums' do
    it do
      is_expected.to(
        define_enum_for(:destination)
          .with_values(
            employees: 'employees',
            recruits: 'recruits'
          )
          .backed_by_column_of_type(:string)
          .with_prefix(:for)
      )
    end
  end
end

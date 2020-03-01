# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Enrolment, type: :model do
  it { is_expected.to have_db_index(:status) }

  it { is_expected.to have_db_index(:group) }

  it { is_expected.to belong_to(:candidate) }

  it { is_expected.to validate_presence_of(:group) }

  it { is_expected.to validate_presence_of(:position) }

  it { is_expected.to validate_presence_of(:status) }

  it { is_expected.to validate_presence_of(:received_at) }

  describe 'enums' do
    it 'expects correct values for status' do
      is_expected.to define_enum_for(:status).backed_by_column_of_type(:string)
    end
  end
end

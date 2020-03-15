# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecruitDocument, type: :model do
  it do
    is_expected
      .to belong_to(:recruit)
      .with_primary_key('human_resources_id')
      .with_foreign_key('encrypted_email')
      .optional
  end

  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to validate_presence_of(:first_name) }

  it { is_expected.to validate_presence_of(:last_name) }

  it { is_expected.to validate_presence_of(:position) }

  it { is_expected.to validate_presence_of(:group) }

  it { is_expected.to validate_presence_of(:received_at) }

  it { is_expected.to validate_presence_of(:source) }

  it { is_expected.to validate_presence_of(:status) }

  describe 'enums' do
    it do
      is_expected.to(
        define_enum_for(:status)
          .with_values(
            fresh: 'fresh',
            accepted: 'accepted',
            rejected: 'rejected'
          )
          .backed_by_column_of_type(:string)
      )
    end
  end
end

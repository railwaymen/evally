# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecruitmentDocument, type: :model do
  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to validate_presence_of(:first_name) }

  it { is_expected.to validate_presence_of(:last_name) }

  it { is_expected.to validate_presence_of(:position) }

  it { is_expected.to validate_presence_of(:group) }

  it { is_expected.to validate_presence_of(:received_at) }

  it { is_expected.to validate_presence_of(:source) }
end

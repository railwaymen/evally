# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_secure_password }

  it { is_expected.to have_db_index(:email) }

  it { is_expected.to have_many(:employees) }

  it { is_expected.to have_many(:templates) }

  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to validate_presence_of(:password) }

  it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(32) }
end

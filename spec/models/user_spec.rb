# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_db_index(:email) }

  it { is_expected.to have_many(:employees).with_foreign_key('evaluator_id') }

  it { is_expected.to have_many(:recruits).with_foreign_key('evaluator_id') }

  it { is_expected.to have_many(:templates) }

  it { is_expected.to have_many(:comments) }

  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to validate_presence_of(:password) }

  it { is_expected.to validate_presence_of(:role) }

  it { is_expected.to validate_presence_of(:status) }

  it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(32) }

  it do
    is_expected.to(
      define_enum_for(:role)
        .with_values(
          evaluator: 'evaluator',
          recruiter: 'recruiter',
          admin: 'admin'
        )
        .backed_by_column_of_type(:string)
    )
  end

  it do
    is_expected.to(
      define_enum_for(:status)
        .with_values(
          inactive: 'inactive',
          active: 'active'
        )
        .backed_by_column_of_type(:string)
    )
  end
end

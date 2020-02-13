# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Template, type: :model do
  it { is_expected.to have_db_index(:name) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to accept_nested_attributes_for(:sections).allow_destroy(true) }

  it { is_expected.to validate_presence_of(:name) }
end

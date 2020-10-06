# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmailTemplate, type: :model do
  it { is_expected.to belong_to(:creator).class_name('User') }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:subject) }

  it { is_expected.to validate_presence_of(:body) }
end

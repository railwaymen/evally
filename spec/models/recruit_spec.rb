# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruit, type: :model do
  it { is_expected.to belong_to(:evaluator).class_name('User').optional }

  it { is_expected.to have_many(:comments) }

  it { is_expected.to validate_presence_of(:public_recruit_id) }
end

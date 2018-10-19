require 'rails_helper'

RSpec.describe Evaluation, type: :model do

  it { is_expected.to belong_to(:employee) }

  it { is_expected.to define_enum_for(:state) }

  it { is_expected.to accept_nested_attributes_for(:sections).allow_destroy(false) }
end

require 'rails_helper'

RSpec.describe Section, type: :model do

  it { is_expected.to belong_to(:sectionable) }

  it { is_expected.to define_enum_for(:group) }

  it { is_expected.to define_enum_for(:width) }
end

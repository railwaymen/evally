# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to belong_to(:user).optional }

  it { is_expected.to belong_to(:recruit) }

  it { is_expected.to validate_presence_of(:body) }

  describe 'enums' do
    it do
      is_expected.to(
        define_enum_for(:created_by)
          .with_values(
            human: 'human',
            bot: 'bot'
          )
          .backed_by_column_of_type(:string)
          .with_prefix(true)
      )
    end
  end
end

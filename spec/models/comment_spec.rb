# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation' do
    it { is_expected.to belong_to(:user).optional }

    it { is_expected.to belong_to(:recruit) }

    it { is_expected.to validate_presence_of(:body) }

    context 'when created by human' do
      subject { Comment.new(created_by: 'human') }

      it { is_expected.to validate_presence_of(:user_id) }
    end

    context 'when created by bot' do
      subject { Comment.new(created_by: 'bot') }

      it { is_expected.not_to validate_presence_of(:user_id) }
    end
  end

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

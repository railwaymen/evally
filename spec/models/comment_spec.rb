# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation' do
    it { is_expected.to belong_to(:user).optional }

    it { is_expected.to belong_to(:recruit) }

    it { is_expected.to validate_presence_of(:body) }

    it { is_expected.to validate_presence_of(:recruit_document_id) }

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
            bot: 'bot',
            mailer: 'mailer'
          )
          .backed_by_column_of_type(:string)
          .with_prefix(true)
      )
    end
  end

  describe 'methods' do
    context '.notifiable_path' do
      it 'returns path to proper recruit document' do
        comment = FactoryBot.create(:comment, recruit_document_id: 1)

        expect(comment.notifiable_path).to eq(
          "/app/recruitments/#{comment.recruit.public_recruit_id}/documents/1"
        )
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruit, type: :model do
  it { is_expected.to belong_to(:evaluator).class_name('User').optional }

  it { is_expected.to have_many(:comments) }

  it { is_expected.to validate_presence_of(:public_recruit_id) }

  describe 'methods' do
    context '.notifiable_path' do
      it 'returns path to proper recruit document' do
        recruit = FactoryBot.create(:recruit)

        expect(recruit.notifiable_path).to eq '/app/recruitments'
      end
    end
  end
end

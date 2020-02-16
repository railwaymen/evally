# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_secure_password }

  it { is_expected.to have_db_index(:email) }

  it { is_expected.to have_many(:employees) }

  it { is_expected.to have_many(:templates) }

  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to validate_presence_of(:password) }

  it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(32) }

  describe '.authentication?' do
    it 'returns false if user inactive' do
      user = FactoryBot.create(:user, password: 'password', status: 'inactive')

      expect(user.authentication?('password')).to eq false
    end

    it 'reutrns false if wrong password' do
      user = FactoryBot.create(:user, password: 'password', status: 'active')
      expect(user.authentication?('wrongpassword')).to eq false
    end

    it 'returns user if user is active and authenticated' do
      user = FactoryBot.create(:user, password: 'password', status: 'active')
      expect(user.authentication?('password')).to eq user
    end
  end
end

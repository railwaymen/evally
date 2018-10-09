require 'rails_helper'

RSpec.describe V1::UserCreateForm do

  let(:form) { V1::UserCreateForm.new(User.new) }

  describe 'validation'do

    it 'expects to return true if params ok' do
      form.attributes = attributes_for(:user)
      expect(form.valid?).to be true
    end

    it 'expects to respond with errors', :aggregate_failures do
      aggregate_failures 'when password blank' do
        form.attributes = attributes_for(:user, password: '')
        expect(form.valid?).to eq false
      end

      aggregate_failures 'when password tooshort' do
        form.attributes = attributes_for(:user, password: '12345')
        expect(form.valid?).to eq false
      end

      aggregate_failures 'when password too long' do
        form.attributes = attributes_for(:user, password: 'a' * 33)
        expect(form.valid?).to eq false
      end

      aggregate_failures 'when email blank' do
        form.attributes = attributes_for(:user, email: '')
        expect(form.valid?).to eq false
      end

      aggregate_failures 'when invalid email' do
        form.attributes = attributes_for(:user, email: 'user@local')
        expect(form.valid?).to eq false
      end

      aggregate_failures 'when email already exists' do
        create(:user, email: 'sample@example.com')

        form.attributes = attributes_for(:user, email: 'sample@example.com')
        expect(form.valid?).to eq false
      end
    end
  end
end

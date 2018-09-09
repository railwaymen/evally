require 'rails_helper'

RSpec.describe V1::UserCreateForm do

  let(:form) { V1::UserCreateForm.new(User.new) }
  let(:params) { attributes_for(:user) }

  describe 'validation'do

    it 'expects to return true if params ok' do
      expect(form.validate(params)).to be true
    end

    context 'expects to respond failure when' do
      after(:each) { expect(form.validate(params)).to eq false }

      it 'password blank' do
        params[:password] = ''
      end

      it 'password too short' do
        params[:password] = 'a' * 5
      end

      it ' password too long' do
        params[:password] = 'a' * 33
      end

      it 'email blank' do
        params[:email] = ''
      end

      it 'invalid email format' do
        params[:email] = 'user@local'
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::Sync::UserSyncService do
  describe '.perform' do
    it 'expects to make a post request' do
      user = FactoryBot.create(:user, role: :admin)

      stub_request(:post, 'http://testhost_recruitable/v2/users/webhook')
        .with(
          body: {
            user: user.attributes.slice(
              'id', 'email', 'first_name', 'last_name', 'role', 'status'
            )
          },
          headers: {
            'Accept' => 'application/json',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'Token' => JwtService.encode(user),
            'User-Agent' => 'Faraday v0.17.3'
          }
        )
        .to_return(status: 204, body: '', headers: {})

      described_class.new(user, user).perform
    end
  end
end

# frozen_string_literal: true

module Devise
  module Strategies
    class JWT < Base
      def valid?
        request.headers['Authorization'].present?
      end

      def authenticate!
        payload = JwtService.decode(token: token)
        success! User.find(payload['user_id'])
      rescue ::JWT::ExpiredSignature
        fail! 'Auth token has expired. Please login again'
      rescue ::JWT::DecodeError
        fail! 'Auth token is invalid'
      rescue
        fail!
      end

      private

      def token
        @token ||= request.headers.fetch('Authorization', '').split(' ').last
      end
    end
  end
end

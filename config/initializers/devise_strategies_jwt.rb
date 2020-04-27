# frozen_string_literal: true

module Devise
  module Strategies
    class JWT < Base
      def valid?
        request.headers['Token'].present? || fail!
      end

      def authenticate!
        success! mapping.to.active.find_by!(email: resource_email)
      rescue ::JWT::ExpiredSignature, ::JWT::VerificationError, ::JWT::DecodeError, KeyError
        fail!
      end

      def store?
        false
      end

      private

      def token
        @token ||= request.headers.fetch('Token', '').split(' ').last
      end

      def resource_email
        JwtService.decode(token).fetch('email')
      end

      def fail!
        raise ErrorResponderService.new(:unauthorized, 401)
      end
    end
  end
end

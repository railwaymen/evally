# frozen_string_literal: true

module V2
  module Emails
    class FormPresenter
      attr_reader :user

      def initialize(user)
        @user = user
      end

      def email_templates
        EmailTemplate.includes(:creator).order(name: :asc)
      end

      def sender_emails
        Rails.application.config.env.dig(:core, :sender_emails).to_s.split(',').map(&:strip)
      end
    end
  end
end

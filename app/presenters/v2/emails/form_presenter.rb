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
    end
  end
end

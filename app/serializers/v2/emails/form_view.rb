# frozen_string_literal: true

module V2
  module Emails
    class FormView < Blueprinter::Base
      association :user, blueprint: V2::Users::Serializer, default: {}

      association :email_templates, blueprint: V2::EmailTemplates::Serializer, default: []
    end
  end
end

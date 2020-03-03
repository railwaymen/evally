# frozen_string_literal: true

module V2
  module Profile
    class ShowView < Blueprinter::Base
      association :user, blueprint: V2::Users::Serializer, default: {}

      association :setting, blueprint: V2::Settings::Serializer, default: {}
    end
  end
end
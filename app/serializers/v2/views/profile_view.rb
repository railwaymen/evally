# frozen_string_literal: true

module V2
  module Views
    class ProfileView < Blueprinter::Base
      association :user, blueprint: V2::Users::Serializer, default: {}

      association :setting, blueprint: V2::SettingSerializer, default: {}
    end
  end
end

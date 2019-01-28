module V1
  class UserSerializer < Blueprinter::Base
    fields :email, :first_name, :last_name

    association :setting, blueprint: V1::SettingSerializer, default: {}
  end
end

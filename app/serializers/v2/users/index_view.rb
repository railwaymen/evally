# frozen_string_literal: true

module V2
  module Users
    class IndexView < Blueprinter::Base
      fields :total_count

      association :users, blueprint: V2::Users::Serializer, default: []
    end
  end
end

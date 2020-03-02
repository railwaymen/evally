# frozen_string_literal: true

module V2
  module Recruitments
    class IndexView < Blueprinter::Base
      association :recruitments, blueprint: V2::Recruitments::Serializer, default: []

      fields :groups, :statuses
    end
  end
end

# frozen_string_literal: true

module V2
  module Employees
    class IndexView < Blueprinter::Base
      association :employees, blueprint: V2::Employees::Serializer, default: []
    end
  end
end

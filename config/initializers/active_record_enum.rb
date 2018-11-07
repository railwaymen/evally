# Use inclusion validation on enum attributes instead of raising ArgumentError

module ActiveRecord
  module Enum
    class EnumType < Type::Value
      def assert_valid_value(value)
        unless value.blank? || mapping.has_key?(value) || mapping.has_value?(value)
          value
        end
      end
    end
  end
end
# frozen_string_literal: true

class HumanResourcesRecord < ActiveRecord::Base
  self.abstract_class = true

  connects_to database: { writing: :hr }
end

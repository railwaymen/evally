class PositionChange < ApplicationRecord
  belongs_to :employee

  default_scope { order(created_at: :desc) }
end
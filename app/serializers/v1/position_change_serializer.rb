module V1
  class PositionChangeSerializer < Blueprinter::Base
    identifier :id

    fields :previous_position, :current_position, :changed_at
  end
end

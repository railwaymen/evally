module V1
  class SectionSerializer < Blueprinter::Base
    identifier :id

    fields :name, :group, :width, :position, :skills
  end
end

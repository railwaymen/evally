# frozen_string_literal: true

module V2
  class TemplatePresenter
    attr_reader :template

    def initialize(template)
      @template = template
    end

    def sections
      @template.sections.order(position: :asc)
    end
  end
end

# frozen_string_literal: true

module V2
  module Templates
    class ShowPresenter
      attr_reader :template

      def initialize(template)
        @template = template
      end

      def sections
        set_section_width = lambda do |section|
          section.width = @template.for_recruits? ? 'full' : section.width

          section
        end

        @template.sections.order(position: :asc).map(&set_section_width)
      end
    end
  end
end

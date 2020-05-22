# frozen_string_literal: true

module V2
  module Templates
    class ShowPresenter
      attr_reader :template

      def initialize(user, template)
        @user = user
        @template = template
      end

      def sections
        set_section_width = lambda do |section|
          section.width = @template.for_recruits? ? 'full' : section.width

          section
        end

        V2::SectionPolicy::Scope.new(@user, sections_scope).resolve.map(&set_section_width)
      end

      private

      def sections_scope
        @template.sections.order(position: :asc)
      end
    end
  end
end

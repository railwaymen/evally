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

        Pundit.policy_scope!(@user, [:v2, sections_scope]).map(&set_section_width)
      end

      private

      def sections_scope
        @template.sections.order(position: :asc)
      end
    end
  end
end

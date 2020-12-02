# frozen_string_literal: true

module V2
  module Shared
    class ServerSideTableQuery
      def initialize(scope, params: {}, require_values: true, custom_columns: [])
        @scope = scope

        @query_params = OpenStruct.new(params)
        @require_values = require_values

        @column_names = scope.klass.column_names | custom_columns
      end

      def paginated_scope
        final_scope.page(@query_params.page || 1).per(@query_params.per_page)
      end

      def total_count
        final_scope.count(:id)
      end

      def final_scope
        return searchable_scope.search_text(@query_params.search) if @query_params.search.present?

        searchable_scope
      end

      private

      def searchable_scope
        @searchable_scope ||= @scope.where(filters_condition).order(order_condition)
      end

      def filters_condition
        return if @query_params.filters.blank?

        @query_params.filters.select do |key, value|
          @column_names.include?(key.to_s) && (@require_values ? value.present? : true)
        end
      end

      def order_condition
        return unless @column_names.include? @query_params.sort_by

        "\"#{@query_params.sort_by}\" #{@query_params.sort_dir == 'asc' ? 'asc' : 'desc'}"
      end
    end
  end
end

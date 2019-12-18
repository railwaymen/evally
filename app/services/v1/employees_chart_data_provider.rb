# frozen_string_literal: true

module V1
  class EmployeesChartDataProvider
    def self.call
      db_result = employees_select.group(:group, :position).collect do |item|
        { item.group => [item.position, item.position_count] }
      end

      grouped_result = db_result.each_with_object({}) do |input, output|
        input.each { |group, counted_position| (output[group] ||= []) << counted_position }
      end

      grouped_result.sort.to_h.as_json
    end

    def employees_select
      Employee.where.not(state: :released).select(
        '"group", "position", COUNT("position") AS "position_count"'
      )
    end

    private_class_method :employees_select
  end
end

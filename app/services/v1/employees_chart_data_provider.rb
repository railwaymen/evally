module V1
  class EmployeesChartDataProvider

    def self.call
      db_result = Employee.where.not(state: :released).select('"group", "position", COUNT("position") AS "position_count"')
        .group(:group, :position).collect{ |item| { item.group => [item.position, item.position_count] } }

      grouped_result = db_result.each_with_object({}) do |input, output|
        input.each { |group, counted_position| (output[group] ||= []) << counted_position }
      end

      grouped_result.sort.to_h.as_json
    end
  end
end

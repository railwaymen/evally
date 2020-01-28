# frozen_string_literal: true

module JsonSpecHelpers
  def json_response
    JSON.parse(response.body)
  end

  def draft_schema(draft) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    employee = draft.employee

    {
      draft: {
        id: draft.id,
        state: draft.state,
        template_name: draft.template_name,
        updated_at: draft.updated_at.to_s,
        employee_id: draft.employee_id,
        employee_first_name: employee.first_name,
        employee_last_name: employee.last_name,
        employee_position: employee.position,
        employee_hired_at: employee.hired_at.to_s,
        next_evaluation_at: employee.next_evaluation_at
      },
      sections: draft.sections.map(&method(:section_schema))
    }.to_json
  end

  def employee_schema(employee)
    {
      first_name: employee.first_name,
      last_name: employee.last_name,
      state: employee.state,
      position: employee.position,
      group: employee.group,
      hired_at: employee.hired_at.to_s,
      position_set_at: employee.position_set_at || employee.hired_at,
      next_evaluation_at: employee.next_evaluation_at
    }.to_json
  end

  def section_schema(section)
    {
      id: section.id,
      group: section.group,
      width: section.width,
      position: section.position,
      name: section.name,
      skills: section.skills
    }
  end

  def template_schema(template)
    {
      template: {
        id: template.id,
        name: template.name
      },
      sections: template.sections.map(&method(:section_schema))
    }.to_json
  end
end

RSpec.configure do |config|
  config.include JsonSpecHelpers, type: :controller
end

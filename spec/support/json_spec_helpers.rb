# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/ModuleLength

module JsonSpecHelpers
  def json_response
    JSON.parse(response.body)
  end

  def draft_schema(draft)
    employee = draft.employee

    {
      draft: {
        id: draft.id,
        state: draft.state,
        template_name: draft.template_name,
        updated_at: draft.updated_at.to_s,
        completed_at: draft.completed_at ? draft.completed_at.to_s : nil,
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

  def evaluation_schema(evaluation)
    employee = evaluation.employee

    {
      evaluation: {
        id: evaluation.id,
        state: evaluation.state,
        template_name: evaluation.template_name,
        updated_at: evaluation.updated_at.to_s,
        completed_at: evaluation.completed_at.to_s,
        employee_id: evaluation.employee_id,
        employee_first_name: employee.first_name,
        employee_last_name: employee.last_name,
        employee_position: employee.position,
        employee_hired_at: employee.hired_at.to_s,
        next_evaluation_at: employee.next_evaluation_at
      },
      sections: evaluation.sections.map(&method(:section_schema))
    }.to_json
  end

  def employee_schema(employee) # rubocop:disable Metrics/MethodLength
    {
      first_name: employee.first_name,
      last_name: employee.last_name,
      state: employee.state,
      position: employee.position,
      group: employee.group,
      hired_at: employee.hired_at.to_s,
      position_set_at: employee.position_set_at || employee.hired_at,
      next_evaluation_at: employee.next_evaluation_at,
      public_token: employee.public_token
    }.to_json
  end

  def profile_schema(user) # rubocop:disable Metrics/MethodLength
    setting = user.setting

    {
      user: {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email
      },
      setting: {
        default_draft_items: setting.default_draft_items,
        default_upcoming_items: setting.default_upcoming_items,
        default_next_evaluation_time: setting.default_next_evaluation_time,
        lang: setting.lang
      }
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

  def setting_schema(setting)
    {
      default_draft_items: setting.default_draft_items,
      default_upcoming_items: setting.default_upcoming_items,
      default_next_evaluation_time: setting.default_next_evaluation_time,
      lang: setting.lang
    }.to_json
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

  def user_schema(user)
    {
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email
    }.to_json
  end
end

RSpec.configure do |config|
  config.include JsonSpecHelpers, type: :controller
end

# rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/ModuleLength

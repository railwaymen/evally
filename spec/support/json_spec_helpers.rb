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
        employee_hired_on: employee.hired_on,
        next_evaluation_on: employee.next_evaluation_on
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
        employee_hired_on: employee.hired_on,
        next_evaluation_on: employee.next_evaluation_on
      },
      sections: evaluation.sections.map(&method(:section_schema))
    }.to_json
  end

  def employee_schema(employee)
    latest_evaluation_date = lambda do
      employee.latest_evaluation_date if employee.respond_to?(:latest_evaluation_date)
    end

    {
      first_name: employee.first_name,
      last_name: employee.last_name,
      state: employee.state,
      position: employee.position,
      group: employee.group,
      hired_on: employee.hired_on,
      position_set_on: employee.position_set_on || employee.hired_on,
      next_evaluation_on: employee.next_evaluation_on,
      public_token: employee.public_token,
      latest_evaluation_date: latest_evaluation_date.call,
      evaluator_id: employee.evaluator_id,
      evaluator_fullname: employee.evaluator&.fullname,
      archived_on: employee.archived_on
    }.to_json
  end

  def profile_schema(user)
    setting = user.setting

    {
      user: {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        role: user.role,
        status: user.status,
        last_sign_in_at: user.last_sign_in_at,
        invitation_status: user.invitation_status
      },
      setting: {
        default_draft_items: setting.default_draft_items,
        default_upcoming_items: setting.default_upcoming_items,
        default_next_evaluation_time: setting.default_next_evaluation_time,
        lang: setting.lang
      }
    }.to_json
  end

  def recruit_document_schema(recruit_document)
    {
      id: recruit_document.id,
      status: recruit_document.status,
      first_name: recruit_document.first_name,
      last_name: recruit_document.last_name,
      email: recruit_document.email,
      gender: recruit_document.gender,
      phone: recruit_document.phone,
      group: recruit_document.group,
      position: recruit_document.position,
      received_at: recruit_document.received_at.to_s,
      source: recruit_document.source
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
        name: template.name,
        destination: template.destination,
        creator_id: template.creator_id,
        creator_fullname: template.creator&.fullname
      },
      sections: template.sections.map(&method(:section_schema))
    }.to_json
  end

  def user_schema(user)
    {
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      role: user.role,
      status: user.status,
      last_sign_in_at: user.last_sign_in_at,
      invitation_status: user.invitation_status
    }.to_json
  end
end

RSpec.configure do |config|
  config.include JsonSpecHelpers, type: :controller
end

# rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/ModuleLength

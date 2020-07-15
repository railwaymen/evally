# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/ModuleLength

module JsonSpecHelpers
  def json_response
    JSON.parse(response.body)
  end

  def comment_schema(comment)
    user = comment.user

    {
      id: comment.id,
      body: comment.discarded_at.blank? ? comment.body : '~~ Comment has been deleted ~~',
      created_at: comment.created_at.to_s,
      created_by: user.fullname,
      user_id: user.id,
      editable: user.present? && comment.created_recently?
    }.to_json
  end

  def evaluation_employable_schema(draft)
    employee = draft.employee

    {
      evaluation: {
        id: draft.id,
        state: draft.state,
        template_name: draft.template_name,
        updated_at: draft.updated_at.to_s,
        completed_at: draft.completed_at ? draft.completed_at.to_s : nil,
        position: draft.position,
        employee_id: draft.employee_id,
        first_name: employee.first_name,
        last_name: employee.last_name,
        hired_on: employee.hired_on,
        next_evaluation_on: employee.next_evaluation_on
      },
      sections: draft.sections.map(&method(:section_schema))
    }.to_json
  end

  def evaluation_recruitable_schema(draft)
    {
      evaluation: {
        id: draft.id,
        state: draft.state,
        template_name: draft.template_name,
        updated_at: draft.updated_at.to_s,
        completed_at: draft.completed_at ? draft.completed_at.to_s : nil,
        position: draft.position,
        recruit_id: draft.recruit_id
      },
      sections: draft.sections.map(&method(:section_schema))
    }.to_json
  end

  def employee_schema(employee)
    evaluated = lambda do
      employee.respond_to?(:evaluated) ? employee.evaluated : nil
    end

    evaluation_exists = lambda do
      employee.respond_to?(:evaluation_exists) ? employee.evaluation_exists : nil
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
      last_evaluation_on: employee.last_evaluation_on,
      public_token: employee.public_token,
      evaluation_exists: evaluation_exists.call,
      evaluated: evaluated.call,
      evaluator_id: employee.evaluator_id,
      evaluator_fullname: employee.evaluator&.fullname,
      archived_on: employee.archived_on
    }.to_json
  end

  def notification_schema(notification)
    {
      id: notification.id,
      body: notification.body,
      notifiable_path: notification.notifiable_path,
      created_at: notification.created_at,
      unread: notification.read_at.blank?
    }
  end

  def profile_schema(user)
    setting = user.setting

    notifications = Notification.where(recipient: user)

    {
      user: {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        email_token: user.email_token,
        role: user.role,
        status: user.status,
        last_sign_in_at: user.last_sign_in_at,
        invitation_status: user.invitation_status
      },
      setting: {
        default_draft_items: setting.default_draft_items,
        default_upcoming_items: setting.default_upcoming_items,
        default_next_evaluation_time: setting.default_next_evaluation_time,
        enable_upcoming_notifications: setting.enable_upcoming_notifications,
        lang: setting.lang
      },
      notifications: notifications.map(&method(:notification_schema)),
      unread_count: notifications.where(read_at: nil).count
    }.to_json
  end

  def section_schema(section)
    {
      id: section.id,
      group: section.group,
      width: section.width,
      position: section.position,
      sensitive: section.sensitive,
      name: section.name,
      skills: section.skills
    }
  end

  def setting_schema(setting)
    {
      default_draft_items: setting.default_draft_items,
      default_upcoming_items: setting.default_upcoming_items,
      default_next_evaluation_time: setting.default_next_evaluation_time,
      enable_upcoming_notifications: setting.enable_upcoming_notifications,
      lang: setting.lang
    }.to_json
  end

  def template_schema(template)
    set_section_width = lambda do |section|
      section.width = template.for_recruits? ? 'full' : section.width

      section
    end

    {
      template: {
        id: template.id,
        name: template.name,
        destination: template.destination,
        creator_id: template.creator_id,
        creator_fullname: template.creator&.fullname
      },
      sections: template.sections.map(&set_section_width).map(&method(:section_schema))
    }.to_json
  end

  def user_schema(user)
    {
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      email_token: user.email_token,
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

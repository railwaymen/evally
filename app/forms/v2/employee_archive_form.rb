# frozen_string_literal: true

module V2
  class EmployeeArchiveForm
    include ActiveModel::Validations

    attr_reader :employee, :archived_on

    validate :archived_on_presence
    validate :existing_drafts

    def initialize(employee, params:, user:)
      @employee = employee
      @archived_on = params[:archived_on]
      @user = user
    end

    def save
      validate_employee!

      ActiveRecord::Base.transaction do
        @employee.update!(state: 'archived', archived_on: @archived_on, evaluator_id: nil)

        create_archive_activity!
      end
    end

    private

    def validate_employee!
      return if valid? && @employee.errors.blank?

      raise ErrorResponderService.new(:invalid_record, 422, @employee.errors.full_messages)
    end

    def archived_on_presence
      return true if @archived_on.present?

      @employee.errors.add(:archived_on, :blank)
    end

    def existing_drafts
      return true unless @employee.evaluations.draft.exists?

      @employee.errors.add(:base, :has_draft_evaluations)
    end

    def create_archive_activity!
      @user.activities.create!(
        action: 'archive',
        activable: @employee,
        activable_name: @employee.fullname
      )
    end
  end
end

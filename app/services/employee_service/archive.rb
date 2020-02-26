# frozen_string_literal: true

module EmployeeService
  class Archive
    include ActiveModel::Validations

    attr_accessor(
      :archived_on,
      :employee
    )

    # validates :archived_on, presence: true

    def initialize(employee:, archived_on:, user:)
      @employee = employee
      @archived_on = archived_on
      @user = user
    end

    def call
      return false unless validate_archived_on

      validate_employee!

      ActiveRecord::Base.transaction do
        archive
        create_archive_activity

        true
      end
    end

    private

    def archive
      @employee.update(archived_on: @archived_on,
                       evaluator_id: nil,
                       state: 'archived')
    end

    def create_archive_activity
      @user.activities.create!(
        action: 'archive',
        activable: @employee,
        activable_name: @employee.fullname
      )
    end

    def validate_archived_on
      return true if @archived_on.present?

      @employee.errors.add(:archived_on, :blank)

      false
    end

    def validate_employee!
      return true if @employee.evaluations.draft.empty?

      @employee.errors.add(:archived_on, :has_draft_evaluations)

      raise ErrorResponderService.new(:invalid_record, 422, @employee.errors.full_messages)
    end
  end
end

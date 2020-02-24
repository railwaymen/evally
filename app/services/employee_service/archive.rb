# frozen_string_literal: true

module EmployeeService
  class Archive
    include ActiveModel::Validations

    def initialize(employee:, archived_on:, user:)
      @employee = employee
      @archived_on = archived_on
      @user = user
    end

    def call
      return false unless validate_employee!

      ActiveRecord::Base.transaction do
        archive
        create_archive_activity

        true
      end
    end

    private

    def archive
      @employee.archived!
      @employee.update(archived_on: @archived_on, evaluator_id: nil)
    end

    def create_archive_activity
      @user.activities.create!(
        action: 'archive',
        activable: @employee,
        activable_name: @employee.fullname
      )
    end

    def validate_employee!
      return true if @employee.evaluations.draft.length.zero?

      @employee.errors.add('evaluations', I18n.t('errors.employee.has_draft_evaluations'))

      raise ErrorResponderService.new(:invalid_record, 422, @employee.errors.full_messages)
    end
  end
end

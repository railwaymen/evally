# frozen_string_literal: true

module EmployeeService
  class Archive
    include ActiveModel::Validations

    validate :draft_evaluations_length

    def initialize(employee:, archived_on:, user:)
      @employee = employee
      @archived_on = archived_on
      @user = user
    end

    def call
      validate

      return false unless errors.empty?

      ActiveRecord::Base.transaction do
        archive
        create_archive_activity
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

    def draft_evaluations_length
      return true if @employee.evaluations.draft.length.zero?

      errors.add('evaluations', 'employye has draft evaluations')

      false
    end
  end
end

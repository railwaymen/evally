# frozen_string_literal: true

module V2
  class EmployeeCreateForm
    attr_reader :employee

    def initialize(params, user:)
      @params = params
      @user = user

      @employee = user.employees.build(params)
    end

    def save
      validate_employee!

      ActiveRecord::Base.transaction do
        @employee.save!
        create_activity!
      end
    end

    private

    def validate_employee!
      return if @employee.valid?

      raise V1::ErrorResponderService.new(:invalid_record, 422, @employee.errors.full_messages)
    end

    def create_activity!
      @user.activities.create!(
        action: 'create',
        activable: @employee,
        activable_name: @employee.fullname
      )
    end
  end
end

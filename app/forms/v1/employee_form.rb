module V1
  class EmployeeForm < ApplicationForm

    FIELDS = ['first_name', 'last_name', 'position', 'hired_at', 'last_evaluation_at', 'next_evaluation_at'].freeze
    attr_accessor *FIELDS

    validates :first_name, presence: true

    validates :last_name, presence: true

    validates :position, presence: true

    validates :hired_at, presence: true

  end
end

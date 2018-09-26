module V1
  class EmployeeCreateForm < Reform::Form
    model :employee

    property :first_name
    property :last_name
    property :position
    property :hired_at
    property :last_evaluation_at
    property :next_evaluation_at

    validates :first_name, presence: true

    validates :last_name, presence: true

    validates :position, presence: true

    validates :hired_at, presence: true
    
  end
end

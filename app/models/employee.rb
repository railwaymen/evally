class Employee < ApplicationRecord
  has_secure_token :public_token

  belongs_to :user
  has_many :evaluations, dependent: :destroy
  has_many :position_changes, dependent: :destroy

  has_one :latest_evaluation, -> { completed.order(completed_at: :desc) }, class_name: 'Evaluation', foreign_key: :employee_id

  # # Scopes
  #
  scope :by_state, Proc.new { |state| where(state: state) if state.present? }

  # # Enums
  #
  enum state: { hired: 0, experienced: 10, released: 20 }

  # # Validation
  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :position, presence: true

  validates :hired_at, presence: true


  attr_accessor :skill

  # # Methods
  #
  def fullname
    [first_name, last_name].join(' ')
  end
end

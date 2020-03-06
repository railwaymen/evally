# frozen_string_literal: true

class Template < ApplicationRecord
  # # Associations
  #
  belongs_to :creator, class_name: 'User', optional: true

  has_many :sections, as: :sectionable, dependent: :destroy
  accepts_nested_attributes_for :sections, allow_destroy: true

  # # Validation
  #
  validates :name, :destination, presence: true

  # # Enums
  #
  enum destination: {
    employees: 'employees',
    recruits: 'recruits'
  }
end

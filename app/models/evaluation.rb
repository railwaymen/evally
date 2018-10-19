class Evaluation < ApplicationRecord

  # # Associations
  #
  belongs_to :employee

  has_many :sections, as: :sectionable, dependent: :destroy
  accepts_nested_attributes_for :sections

  # # Enums
  #
  enum state: { draft: 0, completed: 10 }
end

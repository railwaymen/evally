# frozen_string_literal: true

class Template < ApplicationRecord
  # # Associations
  #
  belongs_to :user

  has_many :sections, as: :sectionable, dependent: :destroy
  accepts_nested_attributes_for :sections, allow_destroy: true

  # # Validation
  #
  validates :name, presence: true
end

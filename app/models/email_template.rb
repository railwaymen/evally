# frozen_string_literal: true

class EmailTemplate < ApplicationRecord
  # # Associations
  #
  belongs_to :creator, class_name: 'User'

  # # Validation
  #
  validates :name, :subject, :body, presence: true
end

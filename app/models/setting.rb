# frozen_string_literal: true

class Setting < ApplicationRecord
  belongs_to :user

  validates :lang, presence: true, inclusion: {
    in: %w[en pl],
    message: :invalid_inclusion
  }
end

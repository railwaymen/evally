class Setting < ApplicationRecord
  belongs_to :user

  validates :lang, presence: true, inclusion: {
    in: ['en', 'pl'],
    message: :invalid_inclusion
  }
end

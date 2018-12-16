class Setting < ApplicationRecord
  belongs_to :user

  validates :lang, presence: true, inclusion: {
    in: ['en', 'pl'],
    message: "'%{value}' is not a valid language"
  }
end

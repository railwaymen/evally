class Section < ApplicationRecord
  belongs_to :sectionable, polymorphic: true

  enum group: { rating: 0, bool: 10, text: 20 }
  enum width: { half: 0, full: 1 }
end

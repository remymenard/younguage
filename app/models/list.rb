class List < ApplicationRecord
  has_many :flashcards

  validates :name, presence: true
end

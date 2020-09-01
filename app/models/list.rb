class List < ApplicationRecord
  has_many :flashcards, dependent: :destroy

  validates :name, presence: true
end

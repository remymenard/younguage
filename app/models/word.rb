class Word < ApplicationRecord
  has_many :flashcards

  validates :word,        presence: true, allow_blank: false
  validates :translation, presence: true, allow_blank: false
end

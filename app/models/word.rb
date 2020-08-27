class Word < ApplicationRecord
  has_many :flashcards
  belongs_to :user

  validates :word,        presence: true, allow_blank: false
  validates :translation, presence: true, allow_blank: false
  validates :user, presence: true
end

class Flashcard < ApplicationRecord
  belongs_to :word
  belongs_to :user

  validates :word, presence: true
  validates :user, presence: true
end

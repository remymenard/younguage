class Flashcard < ApplicationRecord
  belongs_to :word
  belongs_to :list

  validates :word, presence: true
  validates :list, presence: true
end

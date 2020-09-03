class List < ApplicationRecord
  has_many :flashcards, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :user, presence: true
end

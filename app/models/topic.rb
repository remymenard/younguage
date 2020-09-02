class Topic < ApplicationRecord
  has_many :articles
  NAMES = ['technology', 'future', 'health', 'work', 'sciences', 'business', 'cultures', 'food', 'programming', 'design', 'politic', 'human', 'self', 'startups']
  validates :name, presence: true, allow_blank: false
end

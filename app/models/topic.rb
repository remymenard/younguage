class Topic < ApplicationRecord
  has_many :articles
  NAMES = ['technology', 'future', 'health', 'work', 'science', 'business', 'culture', 'food', 'programming', 'design', 'politics', 'human', 'self', 'startups']
  validates :name, presence: true, allow_blank: false
end

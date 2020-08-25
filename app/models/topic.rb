class Topic < ApplicationRecord
  has_many :articles

  validates :name, presence: true, allow_blank: false
end

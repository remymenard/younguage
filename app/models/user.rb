class User < ApplicationRecord
  has_many :flashcards
  has_many :orders
  has_many :daily_reports
  has_many :lists
  has_many :words


  # validates_inclusion_of :topics, in: Topic::NAMES
  validate :check_topics, on: :update
  # validates :username, presence: true, allow_blank: false, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def check_topics
    if !topics.all? { |e| Topic::NAMES.include?(e) }
      errors.add(:topics, "The selected topics doesn't exist.")
    end
  end
end

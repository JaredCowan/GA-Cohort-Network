class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :document
  has_many :answers
  acts_as_votable

  paginates_per 10

  accepts_nested_attributes_for :document

  validates :subject, presence: true,
                      length: { minimum: 2 }

  validates :body, presence: true,
                      length: { minimum: 2 }

  validates :user_id, presence: true

end
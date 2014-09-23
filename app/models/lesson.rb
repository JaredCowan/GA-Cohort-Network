class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :document

  paginates_per 50
  accepts_nested_attributes_for :document

  validates :instructor, presence: true
  validates :start,      presence: true
  validates :end,        presence: true
  validates :assistant,  presence: true
  validates :user_id,    presence: true
  validates :classroom,  presence: true
  validates :title,      presence: true

  validates :subject,     presence: true,
                          length: { minimum: 2 }

  validates :description, presence: true,
                          length: { minimum: 2 }

end
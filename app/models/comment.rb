class Comment < ActiveRecord::Base
  acts_as_votable
  belongs_to :status
  belongs_to :user

  validates :body, presence: true,
                      length: { minimum: 2 }

  validates :status_id, presence: true

  validates :user_id, presence: true
end
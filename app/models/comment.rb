class Comment < ActiveRecord::Base
  belongs_to :status
  belongs_to :user
  acts_as_votable
  has_many :activities, :as => :targetable, :dependent => :destroy

  validates :body, presence: false
  # ,
  #                     length: { minimum: 2 }

  validates :status_id, presence: false

  validates :user_id, presence: false

end
class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  acts_as_votable
  has_many :activities, :as => :targetable, :dependent => :destroy
  validates :body, presence: true,
                      length: { minimum: 2 }

  validates :question_id, presence: true

  validates :user_id, presence: true

end
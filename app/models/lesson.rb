class Lesson < ActiveRecord::Base
  belongs_to :user
  has_many :activities, :as => :targetable, :dependent => :destroy
  
  paginates_per 6

  # validates :instructor, presence: true
  # validates :start,      presence: true
  # validates :end,        presence: true
  # validates :assistant,  presence: true
  # validates :user_id,    presence: true
  # validates :classroom,  presence: true
  # validates :title,      presence: true

  # validates :subject,     presence: true,
  #                         length: { minimum: 2 }

  # validates :description, presence: true,
                          # length: { minimum: 2 }

end
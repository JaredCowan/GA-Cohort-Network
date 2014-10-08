class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :document
  has_many :comments
  before_destroy :delete_activity
  acts_as_votable

  paginates_per 10

  accepts_nested_attributes_for :document

  validates :subject, presence: true,
                      length: { minimum: 2 }

  validates :content, presence: true,
                      length: { minimum: 2 }

  validates :user_id, presence: true

  def name_with_initial
    "#{subject}"
  end

  def delete_activity
    Activity.find_by(targetable_id: self.class.find(self.id)).destroy!
  end  

end
class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :document
  has_many :comments
  has_many :activities, :as => :targetable, :dependent => :destroy
  acts_as_votable

  paginates_per 10

  accepts_nested_attributes_for :document

  validates :content, presence: true,
                      length: { minimum: 2 }

  validates :user_id, presence: true

  def name_with_initial
    "#{subject}"
  end

end
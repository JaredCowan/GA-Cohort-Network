class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :document
  has_many :comments

  paginates_per 20
  accepts_nested_attributes_for :document

  validates :subject, presence: true,
                      length: { minimum: 2 }

  validates :content, presence: true,
                      length: { minimum: 2 }

  validates :user_id, presence: true

  def name_with_initial
    "#{subject}"
  end

end
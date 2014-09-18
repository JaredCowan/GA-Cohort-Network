class Status < ActiveRecord::Base
  # attr_accessible :content, :document_attributes
  belongs_to :user
  belongs_to :document
  has_many :comments

  accepts_nested_attributes_for :document

  validates :subject, presence: true,
                      length: { minimum: 2 }

  validates :content, presence: true,
                      length: { minimum: 2 }

  validates :user_id, presence: true

end
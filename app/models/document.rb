class Document < ActiveRecord::Base
  attr_accessor :document
  belongs_to :status
  belongs_to :question
  belongs_to :lesson
  belongs_to :user
  belongs_to :post
  has_many :activities, :as => :targetable, :dependent => :destroy
  has_attached_file :attachment
  validates_attachment_file_name :attachment, :matches => [/png\Z/, /jpg\Z/, /gif\Z/, /jpeg\Z/]
  # validates :user_id, presence: true

  attr_accessor :remove_attachment
  before_save :perform_attachment_removal
  def perform_attachment_removal
    if remove_attachment == '1' && !attachment.dirty?
      self.attachment = nil
    end
  end

end
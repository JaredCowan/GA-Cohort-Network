class Document < ActiveRecord::Base
  attr_accessor :document
  belongs_to :status
  belongs_to :lesson
  belongs_to :user
  # user = User.find_by(email: params[:session][:email].downcase)
  # before_save { user_id = @user.id }
  has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_file_name :attachment, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]
  # validates :user_id, presence: true
  # attr_accessor :remove_attachment


#   before_save :perform_attachment_removal
#   def perform_attachment_removal
#     if attachment
#       @current_user.id = 2
#     end
#   end

end
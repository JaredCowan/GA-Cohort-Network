class Job < ActiveRecord::Base
  belongs_to :user
  acts_as_votable
  before_destroy
  
  paginates_per 10

  # validates :userid , presence: true
  # validates :company, presence: true
  # validates :contactperson , presence: true
  # validates :contactnumber , presence: true
  # validates :position, presence: true
  # validates :type, presence: true
  # validates :desription, presence: true
  # validates :responsibilities, presence: true
  # validates :qualifications, presence: true
  # validates :address, presence: true
  # validates :city, presence: true
  # validates :state, presence: true
  # validates :zip, presence: true
  
  def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where("user_id IN (:followed_user_ids) OR user_id = :user_id",
          followed_user_ids: followed_user_ids, user_id: user)
  end

  def delete_activity
    Activity.find_by(targetable_id: self.class.find(self.id)).destroy!
  end

end
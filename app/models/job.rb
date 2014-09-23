class Job < ActiveRecord::Base
  belongs_to :user
  
  # paginates_per 50

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
end
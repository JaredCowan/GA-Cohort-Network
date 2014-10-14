class Album < ActiveRecord::Base
  belongs_to :user
  has_many :pictures
  has_many :activities, :as => :targetable, :dependent => :destroy
  # attr_accessible :title
end
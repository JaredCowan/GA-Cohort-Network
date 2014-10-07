class Tag < ActiveRecord::Base
  has_many :questions, through: :taggings
  has_many :taggings
  has_many :users
end

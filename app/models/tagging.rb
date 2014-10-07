class Tagging < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  belongs_to :tag
end

class Tagging < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  belongs_to :tag
  before_save { self.user_id = Question.find(self.question_id).user.id }
  after_save :user_activity

  def user_activity
    # User.find(self.user_id).create_activity(self, 'created')
  end
end
